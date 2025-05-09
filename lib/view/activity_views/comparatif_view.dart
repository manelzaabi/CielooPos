import 'package:flutter/material.dart';
import 'package:cieloo/services/api_service.dart';

class ComparatifView extends StatefulWidget {
  const ComparatifView({super.key});

  @override
  State<ComparatifView> createState() => _ComparatifViewState();
}

class _ComparatifViewState extends State<ComparatifView> {
  final List<String> _filters = ['Magasin', 'Terminale', 'Vendeur'];
  int _selectedIndex = 0;

  final List<String> _filters1 = [
    'Option A',
    'Option B',
    'Option C',
  ];
  int _selectedIndex1 = 0;
  List<Map<String, dynamic>> _warehouses = [];

  @override
  void initState() {
    super.initState();
    _loadWarehouses();
  }

  void _loadWarehouses() async {
    try {
      ApiService apiService = ApiService();
      List<Map<String, dynamic>> warehouses =
          await apiService.fetchWarehouses();

      warehouses.sort((a, b) => b['sales'].compareTo(a['sales']));

      if (!mounted) return; // Vérification avant `setState()`

      setState(() {
        _warehouses = warehouses;
      });
    } catch (e) {
      print("Erreur lors du chargement des magasins: $e");
    }
  }

  void _onToggle(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _filterData(_filters[index]);
  }

  void _onToggle1(int index) {
    setState(() {
      _selectedIndex1 = index;
    });
    _filterData1(_filters1[index]);
  }

  void _filterData(String selectedFilter) {
    print('Selected Filter: $selectedFilter');
  }

  void _filterData1(String selectedFilter1) {
    print('Selected Filter 1: $selectedFilter1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: ToggleButtons(
                isSelected: List.generate(
                  _filters.length,
                  (index) => index == _selectedIndex,
                ),
                onPressed: _onToggle,
                children: _filters
                    .map(
                      (filter) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(filter),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ToggleButtons(
                isSelected: List.generate(
                  _filters1.length,
                  (index) => index == _selectedIndex1,
                ),
                onPressed: _onToggle1,
                children: _filters1
                    .map(
                      (filter) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(filter),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 20),
            _warehouses.isEmpty
                ? const Center(child: Text("Aucun magasin disponible"))
                : _buildWarehouseList(),
          ],
        ),
      ),
    );
  }

  Widget _buildWarehouseList() {
    return ListView.builder(
      shrinkWrap: true, // Important pour `SingleChildScrollView`
      physics:
          NeverScrollableScrollPhysics(), // Évite le conflit de scroll avec `SingleChildScrollView`
      itemCount: _warehouses.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: const Icon(Icons.store, color: Colors.blue),
            title: Text(
              _warehouses[index]['label'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "Chiffre d'affaires : ${_warehouses[index]['sales'].toStringAsFixed(2)} dt",
              style: const TextStyle(color: Colors.green, fontSize: 16),
            ),
          ),
        );
      },
    );
  }
}
