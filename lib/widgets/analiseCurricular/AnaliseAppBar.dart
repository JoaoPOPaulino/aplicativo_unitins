import 'package:flutter/material.dart';

class AnaliseAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  const AnaliseAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Análise Curricular'),
      backgroundColor: Colors.blue[700],
    );
  }
}