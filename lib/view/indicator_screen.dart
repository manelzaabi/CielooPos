import 'package:flutter/material.dart';
import 'package:cieloo/view/custom_app_bar.dart';

class IndicatorScreen extends StatefulWidget {
  const IndicatorScreen({super.key});

  @override
  State<IndicatorScreen> createState() => _IndicatorScreenState();
}

class _IndicatorScreenState extends State<IndicatorScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(appBar: CustomAppBar());
  }
}
