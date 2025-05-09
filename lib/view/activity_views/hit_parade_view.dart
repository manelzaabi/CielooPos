import 'package:flutter/material.dart';
import 'package:cieloo/services/api_service.dart';
import 'package:cieloo/view/activity_views/PieChartWidget.dart';
import 'package:intl/intl.dart';

class HitParadeView extends StatefulWidget {
  const HitParadeView({super.key});

  @override
  State<HitParadeView> createState() => _HitParadeViewState();
}

class _HitParadeViewState extends State<HitParadeView> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final List<String> _filters = ['Magasin', 'Vendeur', 'Groupe', 'Terminale'];
  int _selectedIndex = 0;

  List<Map<String, dynamic>> _salesData = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialiser avec la date du jour
    final now = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd').format(now);
    _startDateController.text = formattedDate;
    _endDateController.text = formattedDate;

    // Charger les données initiales
    _fetchSalesData();
  }

  Future<void> _fetchSalesData() async {
    setState(() => _isLoading = true);

    try {
      ApiService apiService = ApiService();

      // Utiliser les dates sélectionnées pour filtrer les données
      String startDate = _startDateController.text;
      String endDate = _endDateController.text;

      List<Map<String, dynamic>> sales = _selectedIndex == 0
          ? await apiService.fetchSalesByWarehouse(
              startDate: startDate, endDate: endDate)
          : await apiService.fetchSalesBySeller();

      if (!mounted) return;

      setState(() {
        _salesData = sales;
        _isLoading = false;
      });
    } catch (e) {
      print("Erreur lors du chargement des ventes : $e");
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _startDateController,
                        decoration: const InputDecoration(
                          labelText: 'Date de début',
                          filled: true,
                          prefixIcon: Icon(Icons.calendar_today),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                        ),
                        readOnly: true,
                        onTap: () => _selectDate(isStartDate: true),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _endDateController,
                        decoration: const InputDecoration(
                          labelText: 'Date de fin',
                          filled: true,
                          prefixIcon: Icon(Icons.calendar_today),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                        ),
                        readOnly: true,
                        onTap: () => _selectDate(isStartDate: false),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _fetchSalesData,
                child: const Text('Filtrer'),
              ),
              const SizedBox(height: 20),
              _buildToggleButtons(),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : Column(
                      children: [
                        _buildSalesTable(),
                        if (_selectedIndex == 0) ...[
                          const SizedBox(height: 20),
                          PieChartWidget(salesByWarehouse: _salesData),
                        ],
                      ],
                    ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButtons() {
    return Container(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ChoiceChip(
              label: Text(_filters[index]),
              selected: _selectedIndex == index,
              onSelected: (selected) {
                setState(() {
                  _selectedIndex = index;
                  _fetchSalesData();
                });
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildSalesTable() {
    if (_salesData.isEmpty) {
      return const Center(
        child: Text('Aucune donnée disponible pour la période sélectionnée'),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Résultats des ventes',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          DataTable(
            columns: const [
              DataColumn(label: Text('Nom')),
              DataColumn(label: Text('Montant'), numeric: true),
            ],
            rows: _salesData.map((item) {
              return DataRow(
                cells: [
                  DataCell(Text(item['magasin'] ?? 'N/A')),
                  DataCell(Text(
                      '${item['ChiffreAffaireConstraintedByDate'] ?? 0} TND')),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate({required bool isStartDate}) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {
        if (isStartDate) {
          _startDateController.text = formattedDate;
        } else {
          _endDateController.text = formattedDate;
        }
      });

      // Optionnel: vous pouvez décider de charger automatiquement les données après la sélection d'une date
      _fetchSalesData();
    }
  }
}
