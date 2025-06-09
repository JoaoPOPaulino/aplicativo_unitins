import 'package:flutter/material.dart';

class ComprovanteAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  const ComprovanteAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Comprovante de Matrícula'),
      backgroundColor: Colors.blue[700],
    );
  }
}