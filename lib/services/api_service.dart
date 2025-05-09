import 'dart:convert';
import 'dart:io';
import 'package:cieloo/models/invoices_response.dart';
import 'package:cieloo/models/login_response.dart';
import 'package:cieloo/models/user_response.dart';
import 'package:cieloo/services/local_storage_service.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final baseUrl = "https://test.cieloo.io/api/index.php";
  Future<LoginResponse> login(String username, String password) async {
    final response = await http.get(
      Uri.parse("$baseUrl/login?login=$username&password=$password"),
    );

    if (response.statusCode == 200) {
      final loginResponse = LoginResponse.fromJson(jsonDecode(response.body));
      if (loginResponse.success?.token != null) {
        LocalStorageService service = LocalStorageService();
        service.saveApiKey(loginResponse.success!.token!);
      }
      return loginResponse;
    } else {
      throw Exception("Failed to login");
    }
  }

  Future<UserResponse> getCurrentUser() async {
    LocalStorageService service = LocalStorageService();
    String? token = await service.getApiKey();
    final response = await http.get(Uri.parse("$baseUrl/users/info"), headers: {
      'DOLAPIKEY': token!,
      HttpHeaders.contentTypeHeader: 'application/json'
    });
    if (response.statusCode == 200) {
      final userResponse = UserResponse.fromJson(jsonDecode(response.body));
      return userResponse;
    } else {
      throw Exception("Failed to retrieve current user");
    }
  }

//Get tickets
  Future<List<Ticket>> fetchTickets({int? type, String? datef}) async {
    LocalStorageService service = LocalStorageService();
    String? token = await service.getApiKey();

    String url = "$baseUrl/invoices";

    List<String> params = [];
    if (type != null) params.add("type=$type");
    if (datef != null) params.add("datef=$datef");

    if (params.isNotEmpty) {
      url += "?${params.join('&')}";
    }

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'DOLAPIKEY': token!,
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);

      List<Ticket> tickets = data.map((json) => Ticket.fromJson(json)).toList();
      tickets.sort((a, b) => b.dateFacture.compareTo(a.dateFacture));

      return tickets;
    } else {
      throw Exception("Erreur lors du chargement des factures");
    }
  }

//Get magasin
  Future<List<Map<String, dynamic>>> fetchWarehouses() async {
    LocalStorageService service = LocalStorageService();
    String? token = await service.getApiKey();

    final response = await http.get(
      Uri.parse("$baseUrl/warehouses"),
      headers: {
        'DOLAPIKEY': token!,
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);

      return data.map((warehouse) {
        return {
          'label': warehouse['label'] as String,
          'sales': (warehouse['sales'] ?? 0).toDouble(),
        };
      }).toList();
    } else {
      print("Failed to load warehouses: ${response.body}");
      throw Exception("Failed to load warehouses");
    }
  }

  Future<List<Map<String, dynamic>>> fetchThirdParties() async {
    LocalStorageService service = LocalStorageService();
    String? token = await service.getApiKey();

    final response = await http.get(
      Uri.parse("$baseUrl/thirdparties"),
      headers: {
        'DOLAPIKEY': token!,
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);

      return data.map((societe) {
        return {
          'nom': societe['name'] as String,
        };
      }).toList();
    } else {
      print("Failed to load sociétés: ${response.body}");
      throw Exception("Failed to load sociétés");
    }
  }

/* 
Future<List<Map<String, dynamic>>> fetchThirdPartiesWithInvoices() async {
  LocalStorageService service = LocalStorageService();
  String? token = await service.getApiKey();  

  final response = await http.get(
    Uri.parse("$baseUrl/thirdparties"),
    headers: {
      'DOLAPIKEY': token!,
      HttpHeaders.contentTypeHeader: 'application/json',
    },
  );

  print("Réponse API ThirdParties: ${response.body}");

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    if (data.isEmpty) {
      print("Aucune société trouvée !");
    }

    List<Map<String, dynamic>> thirdParties = [];

    for (var societe in data) {
      int societeId = int.tryParse(societe['id'].toString()) ?? 0;  // Convertir l'ID en int
      List<Map<String, dynamic>> invoices = await fetchInvoicesByThirdParty(societeId);
      thirdParties.add({
        'id': societeId,
        'nom': societe['name'],
        'invoices': invoices,
      });
    }

    return thirdParties;
  } else {
    print("Erreur API: ${response.statusCode} - ${response.body}");
    throw Exception("Failed to load sociétés");
  }
}



Future<List<Map<String, dynamic>>> fetchInvoicesByThirdParty(int thirdPartyId) async {
  LocalStorageService service = LocalStorageService();
  String? token = await service.getApiKey();  

  final response = await http.get(
    Uri.parse("$baseUrl/invoices?thirdparty_id=$thirdPartyId"),
    headers: {
      'DOLAPIKEY': token!,
      HttpHeaders.contentTypeHeader: 'application/json',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);

    return data.map((invoice) {
      return {
        'ref': invoice['ref'],
        'total': invoice['total_ttc'],
        'date': invoice['date'],
      };
    }).toList();
  } else {
    print("Failed to load invoices: ${response.body}");
    return [];
  }
} */

  Future<List<Map<String, dynamic>>> fetchTopFiveThirdParties() async {
    LocalStorageService service = LocalStorageService();
    String? token = await service.getApiKey();

    final response = await http.get(
      Uri.parse("$baseUrl/thirdparties"),
      headers: {
        'DOLAPIKEY': token!,
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    //print("Réponse API ThirdParties: ${response.body}");

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      if (data.isEmpty) {
        print("Aucune société trouvée !");
        return [];
      }

      List<Map<String, dynamic>> thirdParties = [];

      for (var societe in data) {
        int societeId = int.tryParse(societe['id'].toString()) ?? 0;
        Map<String, dynamic> invoiceData = await fetchInvoiceSummary(societeId);

        thirdParties.add({
          'nom': societe['name'],
          'totalFactures': invoiceData['totalFactures'],
          'chiffreAffaires': invoiceData['chiffreAffaires'],
        });
      }

      // Trier par chiffre d'affaires décroissant et garder le top 5
      thirdParties
          .sort((a, b) => b['chiffreAffaires'].compareTo(a['chiffreAffaires']));
      return thirdParties.take(5).toList();
    } else {
      print("Erreur API: ${response.statusCode} - ${response.body}");
      throw Exception("Failed to load sociétés");
    }
  }

  Future<Map<String, dynamic>> fetchInvoiceSummary(int societeId) async {
    LocalStorageService service = LocalStorageService();
    String? token = await service.getApiKey();

    final response = await http.get(
      Uri.parse(
          "$baseUrl/invoices?societe_id=$societeId&type=0"), // Filtre factures type 0
      headers: {
        'DOLAPIKEY': token!,
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> invoices = jsonDecode(response.body);

      int totalFactures = invoices.length;
      double chiffreAffaires = invoices.fold(0.0, (sum, invoice) {
        return sum +
            (double.tryParse(invoice['total_ttc'].toString()) ??
                0.0); // Utilisation de total_ttc
      });

      return {
        'totalFactures': totalFactures,
        'chiffreAffaires': chiffreAffaires,
      };
    } else {
      return {'totalFactures': 0, 'chiffreAffaires': 0.0};
    }
  }

  Future<List<Map<String, dynamic>>> fetchSalesByWarehouse(
      {String? startDate, String? endDate}) async {
    print("🚀 fetchSalesByWarehouse() a été appelée !");
    LocalStorageService service = LocalStorageService();
    String? token = await service.getApiKey();
    final invoicesResponse = await http.get(
      Uri.parse("$baseUrl/invoices"),
      headers: {
        'DOLAPIKEY': token!,
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (invoicesResponse.statusCode != 200) {
      throw Exception("Erreur lors du chargement des factures");
    }

    // Récupérer toutes les factures
    List<dynamic> allInvoices = jsonDecode(invoicesResponse.body);

    // Préparer les factures filtrées par date si nécessaire
    List<dynamic> dateFilteredInvoices = allInvoices;
    if (startDate != null && endDate != null) {
      DateTime start = DateTime.parse(startDate);
      DateTime end = DateTime.parse(endDate);
      end = end
          .add(const Duration(days: 1))
          .subtract(const Duration(seconds: 1)); // Fin de journée

      dateFilteredInvoices = allInvoices.where((invoice) {
        dynamic dateValue = invoice['date'];
        if (dateValue == null) return false;

        try {
          DateTime invoiceDate;
          if (dateValue is int) {
            // Convert Unix timestamp (seconds since epoch) to DateTime
            invoiceDate = DateTime.fromMillisecondsSinceEpoch(dateValue * 1000);
          } else if (dateValue is String) {
            // Parse date string
            invoiceDate = DateTime.parse(dateValue);
          } else {
            print(
                "⚠️ Format de date non pris en charge: $dateValue (${dateValue.runtimeType})");
            return false;
          }
          return invoiceDate.isAfter(start) && invoiceDate.isBefore(end);
        } catch (e) {
          print("⚠️ Erreur de parsing de date: $dateValue (${e.toString()})");
          return false;
        }
      }).toList();

      print(
          "📅 Filtrage par date: ${allInvoices.length} → ${dateFilteredInvoices.length} factures");
    }

    // 🔹 Extraire les fk_product et calculer le CA pour TOUTES les factures (non filtré par date)
    Map<int, double> totalProductSales = {};
    for (var invoice in allInvoices) {
      List<dynamic> lines = invoice['lines'] ?? [];
      for (var line in lines) {
        int? productId = int.tryParse(line['fk_product']?.toString() ?? '');
        double total =
            double.tryParse(line['total_ttc']?.toString() ?? '0.0') ?? 0.0;

        if (productId != null && productId > 0) {
          totalProductSales[productId] =
              (totalProductSales[productId] ?? 0) + total;
        }
      }
    }

    // 🔹 Extraire les fk_product et calculer le CA pour les factures filtrées par date
    Map<int, double> dateFilteredProductSales = {};
    for (var invoice in dateFilteredInvoices) {
      List<dynamic> lines = invoice['lines'] ?? [];
      for (var line in lines) {
        int? productId = int.tryParse(line['fk_product']?.toString() ?? '');
        double total =
            double.tryParse(line['total_ttc']?.toString() ?? '0.0') ?? 0.0;

        if (productId != null && productId > 0) {
          dateFilteredProductSales[productId] =
              (dateFilteredProductSales[productId] ?? 0) + total;
        }
      }
    }

    // 🔹 Récupérer les mouvements de stock
    final stockMovementsResponse = await http.get(
      Uri.parse("$baseUrl/stockmovements"),
      headers: {
        'DOLAPIKEY': token,
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    print("📥 Réponse API stock : ${stockMovementsResponse.statusCode}");
    if (stockMovementsResponse.statusCode != 200) {
      throw Exception("Erreur lors du chargement des mouvements de stock");
    }

    List<dynamic> stockMovements = jsonDecode(stockMovementsResponse.body);

    if (stockMovements.isNotEmpty) {
      print("🔍 Premier mouvement de stock : ${stockMovements.first}");
    } else {
      print("⚠️ Aucun mouvement de stock trouvé !");
    }

    // 🔹 Associer chaque produit à TOUS ses magasins
    Map<int, List<int>> productToWarehouses = {};
    for (var movement in stockMovements) {
      int? warehouseId =
          int.tryParse(movement["warehouse_id"]?.toString() ?? '');
      int? productId = int.tryParse(movement["product_id"]?.toString() ?? '');

      if (warehouseId != null &&
          productId != null &&
          warehouseId > 0 &&
          productId > 0) {
        productToWarehouses.putIfAbsent(productId, () => []).add(warehouseId);
      }
    }

    print("🏬 Association produit → magasins : $productToWarehouses");

    // 🔹 Regrouper les ventes totales par magasin
    Map<int, double> totalWarehouseSales = {};
    totalProductSales.forEach((productId, sales) {
      List<int>? warehouses = productToWarehouses[productId];

      if (warehouses != null && warehouses.isNotEmpty) {
        // Répartir les ventes équitablement entre les magasins du produit
        double salesPerWarehouse = sales / warehouses.length;

        for (int warehouseId in warehouses) {
          totalWarehouseSales[warehouseId] =
              (totalWarehouseSales[warehouseId] ?? 0) + salesPerWarehouse;
        }
      } else {
        print("⚠️ Produit $productId sans entrepôt associé !");
      }
    });

    // 🔹 Regrouper les ventes filtrées par date par magasin
    Map<int, double> dateFilteredWarehouseSales = {};
    dateFilteredProductSales.forEach((productId, sales) {
      List<int>? warehouses = productToWarehouses[productId];

      if (warehouses != null && warehouses.isNotEmpty) {
        // Répartir les ventes équitablement entre les magasins du produit
        double salesPerWarehouse = sales / warehouses.length;

        for (int warehouseId in warehouses) {
          dateFilteredWarehouseSales[warehouseId] =
              (dateFilteredWarehouseSales[warehouseId] ?? 0) +
                  salesPerWarehouse;
        }
      }
    });

    // 🔹 Récupérer les noms des magasins
    final warehousesResponse = await http.get(
      Uri.parse("$baseUrl/warehouses"),
      headers: {
        'DOLAPIKEY': token,
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (warehousesResponse.statusCode != 200) {
      throw Exception("Erreur lors du chargement des magasins");
    }

    List<dynamic> warehouses = jsonDecode(warehousesResponse.body);
    Map<int, String> warehouseNames = {};
    for (var warehouse in warehouses) {
      int? warehouseId = int.tryParse(warehouse['id']?.toString() ?? '');
      String? label = warehouse['label'] as String?;

      if (warehouseId != null && label != null) {
        warehouseNames[warehouseId] = label;
      }
    }

    // 🔹 Transformer les données en liste
    List<Map<String, dynamic>> result =
        totalWarehouseSales.entries.map((entry) {
      int warehouseId = entry.key;
      double totalSales = entry.value;
      double dateLimitedSales = dateFilteredWarehouseSales[warehouseId] ?? 0.0;

      return {
        'magasin': warehouseNames[warehouseId] ?? 'Inconnu',
        'chiffreAffairesTotal': totalSales,
        'ChiffreAffaireConstraintedByDate': dateLimitedSales
      };
    }).toList();

    // 🔍 **Logs pour le débogage**
    /*   print("🛍️ Ventes par produit avant regroupement : $productSales");
  print("🏬 Association produit → magasins : $productToWarehouses");
  print("💰 Chiffre d'affaires par magasin : $warehouseSales");
  print("🏪 Liste des magasins avec noms : $warehouseNames");
  print("📊 Résultat final trié : $result"); */

    // 🔹 Trier par chiffre d'affaires décroissant
    result.sort((a, b) =>
        b['chiffreAffairesTotal'].compareTo(a['chiffreAffairesTotal']));
    for (int i = 0; i < result.length; i++) {
      result[i]['rang'] = "#${i + 1}";
    }

    return result;
  }

  /* Future<List<Map<String, dynamic>>> fetchSalesByWarehouse(
      {String? startDate, String? endDate}) async {
    print("🚀 fetchSalesByWarehouse() a été appelée !");
    LocalStorageService service = LocalStorageService();
    String? token = await service.getApiKey();

    if (token == null) {
      print("❌ Erreur: Token API non disponible");
      return [];
    }

    // 🔹 Récupérer toutes les factures
    final invoicesResponse = await http.get(
      Uri.parse("$baseUrl/invoices"),
      headers: {
        'DOLAPIKEY': token,
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    // Construire l'URL avec les paramètres de date pour les logs
    String url = '$baseUrl/warehouse';
    if (startDate != null && endDate != null) {
      url += '?startDate=$startDate&endDate=$endDate';
    }
    if (invoicesResponse.statusCode != 200) {
      throw Exception("Erreur lors du chargement des factures");
    }

    // Filtrer les factures par date si nécessaire
    List<dynamic> allInvoices = jsonDecode(invoicesResponse.body);
    List<dynamic> invoices = allInvoices;

    if (startDate != null && endDate != null) {
      DateTime start = DateTime.parse(startDate);
      DateTime end = DateTime.parse(endDate);
      end = end
          .add(const Duration(days: 1))
          .subtract(const Duration(seconds: 1)); // Fin de journée

      invoices = allInvoices.where((invoice) {
        String? dateStr = invoice['date'];
        if (dateStr == null) return false;

        try {
          DateTime invoiceDate = DateTime.parse(dateStr);
          return invoiceDate.isAfter(start) && invoiceDate.isBefore(end);
        } catch (e) {
          print("⚠️ Erreur de parsing de date: $dateStr");
          return false;
        }
      }).toList();

      print(
          "📅 Filtrage par date: ${allInvoices.length} → ${invoices.length} factures");
    }

    // 🔹 Extraire les fk_product et calculer le CA
    Map<int, double> productSales = {};
    for (var invoice in invoices) {
      List<dynamic> lines = invoice['lines'] ?? [];
      for (var line in lines) {
        int? productId = int.tryParse(line['fk_product']?.toString() ?? '');
        double total =
            double.tryParse(line['total_ttc']?.toString() ?? '0.0') ?? 0.0;

        if (productId != null && productId > 0) {
          productSales[productId] = (productSales[productId] ?? 0) + total;
        }
      }
    }

    // 🔹 Récupérer les mouvements de stock
    final stockMovementsResponse = await http.get(
      Uri.parse("$baseUrl/stockmovements"),
      headers: {
        'DOLAPIKEY': token,
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    print("📥 Réponse API stock : ${stockMovementsResponse.statusCode}");
    if (stockMovementsResponse.statusCode != 200) {
      throw Exception("Erreur lors du chargement des mouvements de stock");
    }

    List<dynamic> stockMovements = jsonDecode(stockMovementsResponse.body);

    if (stockMovements.isNotEmpty) {
      print("🔍 Premier mouvement de stock : ${stockMovements.first}");
    } else {
      print("⚠️ Aucun mouvement de stock trouvé !");
    }

    // 🔹 Associer chaque produit à TOUS ses magasins
    Map<int, List<int>> productToWarehouses = {};
    for (var movement in stockMovements) {
      int? warehouseId =
          int.tryParse(movement["warehouse_id"]?.toString() ?? '');
      int? productId = int.tryParse(movement["product_id"]?.toString() ?? '');

      if (warehouseId != null &&
          productId != null &&
          warehouseId > 0 &&
          productId > 0) {
        productToWarehouses.putIfAbsent(productId, () => []).add(warehouseId);
      }
    }

    print("🏬 Association produit → magasins : $productToWarehouses");

    // 🔹 Regrouper les ventes totales par magasin
    Map<int, double> totalWarehouseSales = {};
    totalProductSales.forEach((productId, sales) {
      List<int>? warehouses = productToWarehouses[productId];

      if (warehouses != null && warehouses.isNotEmpty) {
        // Répartir les ventes équitablement entre les magasins du produit
        double salesPerWarehouse = sales / warehouses.length;

        for (int warehouseId in warehouses) {
          totalWarehouseSales[warehouseId] =
              (totalWarehouseSales[warehouseId] ?? 0) + salesPerWarehouse;
        }
      } else {
        print("⚠️ Produit $productId sans entrepôt associé !");
      }
    });
    
    // 🔹 Regrouper les ventes filtrées par date par magasin
    Map<int, double> dateFilteredWarehouseSales = {};
    dateFilteredProductSales.forEach((productId, sales) {
      List<int>? warehouses = productToWarehouses[productId];

      if (warehouses != null && warehouses.isNotEmpty) {
        // Répartir les ventes équitablement entre les magasins du produit
        double salesPerWarehouse = sales / warehouses.length;

        for (int warehouseId in warehouses) {
          dateFilteredWarehouseSales[warehouseId] =
              (dateFilteredWarehouseSales[warehouseId] ?? 0) + salesPerWarehouse;
        }
      }
    });

    // 🔹 Récupérer les noms des magasins
    final warehousesResponse = await http.get(
      Uri.parse("$baseUrl/warehouses"),
      headers: {
        'DOLAPIKEY': token,
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (warehousesResponse.statusCode != 200) {
      throw Exception("Erreur lors du chargement des magasins");
    }

    List<dynamic> warehouses = jsonDecode(warehousesResponse.body);
    Map<int, String> warehouseNames = {};
    for (var warehouse in warehouses) {
      int? warehouseId = int.tryParse(warehouse['id']?.toString() ?? '');
      String? label = warehouse['label'] as String?;

      if (warehouseId != null && label != null) {
        warehouseNames[warehouseId] = label;
      }
    }

    // 🔹 Transformer les données en liste
    List<Map<String, dynamic>> result = warehouseSales.entries.map((entry) {
      return {
        'name': warehouseNames[entry.key] ?? 'Inconnu',
        'amount': entry.value,
      };
    }).toList();

    // 🔹 Trier par chiffre d'affaires décroissant
    result.sort((a, b) => b['amount'].compareTo(a['amount']));
    for (int i = 0; i < result.length; i++) {
      result[i]['rang'] = "#${i + 1}";
    }

    print("📊 Résultat final: ${result.length} magasins avec données");
    return result;
  }
 */
  Future<List<Map<String, dynamic>>> fetchSalesBySeller(
      {String? startDate, String? endDate}) async {
    print("🚀 fetchSalesBySeller() a été appelée !");
    LocalStorageService service = LocalStorageService();
    String? token = await service.getApiKey();

    if (token == null) {
      print("❌ Erreur: Token API non disponible");
      return [];
    }

    // 🔹 Récupérer toutes les factures
    final invoicesResponse = await http.get(
      Uri.parse("$baseUrl/invoices"),
      headers: {
        'DOLAPIKEY': token,
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    // Construire l'URL avec les paramètres de date pour les logs
    String url = '$baseUrl/invoices';
    if (startDate != null && endDate != null) {
      url += '?startDate=$startDate&endDate=$endDate';
    }
    print("🔗 URL de référence : $url");

    if (invoicesResponse.statusCode != 200) {
      throw Exception("Erreur lors du chargement des factures");
    }

    // Filtrer les factures par date si nécessaire
    List<dynamic> allInvoices = jsonDecode(invoicesResponse.body);
    List<dynamic> invoices = allInvoices;

    if (startDate != null && endDate != null) {
      DateTime start = DateTime.parse(startDate);
      DateTime end = DateTime.parse(endDate);
      end = end
          .add(const Duration(days: 1))
          .subtract(const Duration(seconds: 1)); // Fin de journée

      invoices = allInvoices.where((invoice) {
        String? dateStr = invoice['date'];
        if (dateStr == null) return false;

        try {
          DateTime invoiceDate = DateTime.parse(dateStr);
          return invoiceDate.isAfter(start) && invoiceDate.isBefore(end);
        } catch (e) {
          print("⚠️ Erreur de parsing de date: $dateStr");
          return false;
        }
      }).toList();

      print(
          "📅 Filtrage par date: ${allInvoices.length} → ${invoices.length} factures");
    }

    // 🔹 Regrouper les ventes par vendeur
    Map<int, double> sellerSales = {}; // Map pour stocker CA par vendeur

    for (var invoice in invoices) {
      int? sellerId = int.tryParse(
          invoice['user_author']?.toString() ?? ''); // Identifiant du vendeur
      double total =
          double.tryParse(invoice['total_ttc']?.toString() ?? '0.0') ?? 0.0;

      if (sellerId != null && sellerId > 0) {
        sellerSales[sellerId] = (sellerSales[sellerId] ?? 0) + total;
      }
    }

    // 🔹 Récupérer les noms des vendeurs
    final usersResponse = await http.get(
      Uri.parse("$baseUrl/users"),
      headers: {
        'DOLAPIKEY': token,
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (usersResponse.statusCode != 200) {
      throw Exception("Erreur lors du chargement des utilisateurs");
    }

    List<dynamic> users = jsonDecode(usersResponse.body);
    Map<int, String> sellerNames = {}; // Associer les ID aux noms des vendeurs

    for (var user in users) {
      int? userId = int.tryParse(user['id']?.toString() ?? '');
      String? name = user['lastname']; // Récupérer le nom du vendeur

      if (userId != null && name != null) {
        sellerNames[userId] = name;
      }
    }

    // 🔹 Transformer les données en liste
    List<Map<String, dynamic>> result = sellerSales.entries.map((entry) {
      return {
        'vendeur': sellerNames[entry.key] ?? 'Inconnu',
        'chiffreAffaires': entry.value,
      };
    }).toList();

    // 🔍 **Logs pour le débogage**
    print("👤 Ventes par vendeur avant tri : $sellerSales");
    print("📊 Résultat final avant tri : $result");

    // 🔹 Trier par chiffre d'affaires décroissant
    result.sort((a, b) =>
        b['chiffreAffairesTotal'].compareTo(a['chiffreAffairesTotal']));
    for (int i = 0; i < result.length; i++) {
      result[i]['rang'] = "#${i + 1}";
    }

    return result;
  }
}
