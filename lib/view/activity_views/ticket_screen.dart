import 'package:flutter/material.dart';
import 'package:cieloo/models/invoices_response.dart';
import 'package:cieloo/services/api_service.dart';
import 'package:intl/intl.dart'; // Pour formater la date

class TicketScreen extends StatefulWidget {
  @override
  _TicketScreenState createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
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
      print("Nombre de tickets récupérés: ${fetchedTickets.length}");

      setState(() {
        tickets = fetchedTickets;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Erreur: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text("Factures (Type Standard)")), // Ajout d'un titre
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : tickets.isEmpty
              ? Center(child: Text("Aucune facture trouvée"))
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text("Réf. Ticket")),
                          DataColumn(label: Text("Prix (TND)")),
                          DataColumn(label: Text("Date")),
                        ],
                        rows: tickets.map((ticket) {
                          return DataRow(cells: [
                            DataCell(Text(ticket.ref)),
                            DataCell(
                                Text("${ticket.prix.toStringAsFixed(2)} TND")),
                            DataCell(Text(DateFormat('dd/MM/yyyy')
                                .format(ticket.dateFacture))),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                ),
    );
  }
}
