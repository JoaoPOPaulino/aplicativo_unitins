import 'package:flutter/material.dart';

class RematriculaAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  const RematriculaAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Rematrícula Online'),
      backgroundColor: Colors.blue[700],
    );
  }
}