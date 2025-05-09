import 'package:flutter/material.dart';
import 'package:cieloo/view/custom_app_bar.dart';

class ReglementScreen extends StatefulWidget {
  const ReglementScreen({super.key});

  @override
  State<ReglementScreen> createState() => _ReglementScreenState();
}

class _ReglementScreenState extends State<ReglementScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(appBar: CustomAppBar());
  }
}
