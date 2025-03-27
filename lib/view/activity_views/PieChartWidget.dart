import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartWidget extends StatelessWidget {
  final List<Map<String, dynamic>> salesByWarehouse;

  PieChartWidget({required this.salesByWarehouse});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Chiffre d'affaires par magasin",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 📊 Pie Chart
            SizedBox(
              width: 180, // Taille réduite pour laisser de la place aux labels
              height: 180,
              child: PieChart(
                PieChartData(
                  sections: _getSections(),
                  sectionsSpace: 2,
                  centerSpaceRadius: 50,
                ),
              ),
            ),
            const SizedBox(width: 20),
            // 🏷️ Labels en dehors du PieChart
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: salesByWarehouse.map((data) {
                return _buildLegendItem(
                  label: "${data['magasin']}: ${data['chiffreAffaires'].toInt()} TND",
                  color: _getColor(salesByWarehouse.indexOf(data)),
                );
              }).toList(),
            ),
          ],
        ),
      ],
    );
  }

  List<PieChartSectionData> _getSections() {
    return salesByWarehouse.map((data) {
      int chiffreAffaires = data['chiffreAffaires'].toInt(); // Convertir en entier

      return PieChartSectionData(
        value: chiffreAffaires.toDouble(),
        color: _getColor(salesByWarehouse.indexOf(data)),
        radius: 50, // Ajuster la taille des sections
        title: "", // Supprimer les labels dans le graphique
      );
    }).toList();
  }

  /// 🌈 Génère des couleurs dynamiques
  Color _getColor(int index) {
    List<Color> colors = [
      Colors.blue,
      Colors.orange,
      Colors.green,
      Colors.purple,
      Colors.teal
    ];
    return colors[index % colors.length];
  }

  /// 📌 Widget pour afficher les labels en dehors du graphique
  Widget _buildLegendItem({required String label, required Color color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.black)), // Texte noir
        ],
      ),
    );
  }
}
