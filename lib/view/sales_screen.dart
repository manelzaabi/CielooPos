import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/custom_app_bar.dart';
import 'package:flutter_application_1/models/invoices_response.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:intl/intl.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final ApiService apiService = ApiService();
  List<Ticket> tickets = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTickets();
  }

  Future<void> fetchTickets() async {
    try {
      List<Ticket> fetchedTickets = await apiService.fetchTickets(type: 0);
      print("Nombre de tickets récupérés: \${fetchedTickets.length}");

      setState(() {
        tickets = fetchedTickets;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Erreur: \$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : tickets.isEmpty
              ? const Center(child: Text("Aucune facture trouvée"))
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text("Réf. Ticket")),
                          DataColumn(label: Text("Prix (TND)")),
                          DataColumn(label: Text("Date")),
                        ],
                        rows: tickets.map((ticket) {
                          return DataRow(cells: [
                            DataCell(Text(ticket.ref)),
                            DataCell(Text("${ticket.prix.toStringAsFixed(2)} TND")),
                            DataCell(Text(DateFormat('dd/MM/yyyy').format(ticket.dateFacture))),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                ),
    );
  }
}