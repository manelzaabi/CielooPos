class Ticket {
  final String ref;
  final double prix;
  final DateTime dateFacture; // Ajout de la date

  Ticket({
    required this.ref,
    required this.prix,
    required this.dateFacture,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
  print("DEBUG - JSON reçu: $json");

  return Ticket(
    ref: json['ref'] ?? 'N/A',
    prix: double.tryParse(json['total_ttc'].toString()) ?? 0.0,
    dateFacture: json['date_creation'] is int
        ? DateTime.fromMillisecondsSinceEpoch(json['date_creation'] * 1000)
        : DateTime.tryParse(json['date_creation'].toString()) ?? 
          DateTime(2000, 1, 1),
  );
}



}
