import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:flutter_application_1/view/activity_views/PieChartWidget.dart';

class HitParadeView extends StatefulWidget {
  const HitParadeView({super.key});

  @override
  State<HitParadeView> createState() => _HitParadeViewState();
}

class _HitParadeViewState extends State<HitParadeView> {
  final TextEditingController _dateController = TextEditingController();
  final List<String> _filters = ['Magasin', 'Vendeur', 'Groupe', 'Terminale'];
  int _selectedIndex = 0;

  List<Map<String, dynamic>> _salesData = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _fetchSalesData() async {
    setState(() => _isLoading = true);

    try {
      ApiService apiService = ApiService();
      List<Map<String, dynamic>> sales = _selectedIndex == 0
          ? await apiService.fetchSalesByWarehouse()
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
                child: TextField(
                  controller: _dateController,
                  decoration: const InputDecoration(
                    labelText: 'Choisir votre date',
                    filled: true,
                    prefixIcon: Icon(Icons.calendar_today),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                  ),
                  readOnly: true,
                  onTap: _selectDate,
                ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ToggleButtons(
        borderRadius: BorderRadius.circular(10),
        isSelected: List.generate(_filters.length, (index) => index == _selectedIndex),
        onPressed: (index) {
          setState(() => _selectedIndex = index);
          _fetchSalesData();
        },
        children: _filters.map((filter) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Text(filter),
        )).toList(),
      ),
    );
  }

  Widget _buildSalesTable() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: _salesData.isEmpty
          ? const Text("Aucune donnée disponible", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 20,
                headingRowColor: MaterialStateColor.resolveWith((states) => const Color.fromARGB(255, 214, 234, 251)),
                dataRowColor: MaterialStateColor.resolveWith((states) => const Color.fromARGB(255, 168, 60, 60)),
                border: TableBorder.all(width: 1, color: const Color.fromARGB(255, 248, 245, 245)),
                columns: [
                  const DataColumn(label: Text("#", style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text(_selectedIndex == 0 ? "Magasin" : "Vendeur", style: const TextStyle(fontWeight: FontWeight.bold))),
                  const DataColumn(label: Text("Chiffre d'affaires (TND)", style: TextStyle(fontWeight: FontWeight.bold))),
                ],
                rows: _salesData.asMap().entries.map(
                  (entry) {
                    String formattedAmount = entry.value['chiffreAffaires'].toInt().toString();
                    return DataRow(
                      color: MaterialStateColor.resolveWith((states) => entry.key % 2 == 0 ? Colors.white : Colors.grey.shade300),
                      cells: [
                        DataCell(Text("#${entry.key + 1}")),
                        DataCell(Row(
                          children: [
                            Icon(Icons.store, color: Colors.blue.shade700, size: 18),
                            const SizedBox(width: 8),
                            Text(entry.value[_selectedIndex == 0 ? 'magasin' : 'vendeur'] ?? 'Inconnu',
                                style: const TextStyle(fontWeight: FontWeight.w500)),
                          ],
                        )),
                        DataCell(Text("$formattedAmount TND", style: const TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 16, 24, 16)))),
                      ],
                    );
                  },
                ).toList(),
              ),
            ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() => _dateController.text = picked.toString().split(" ")[0]);
    }
  }
}
