import 'package:flutter/material.dart';

class GradeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onInfoPressed;

  const GradeAppBar({
    super.key,
    required this.onInfoPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Grade Curricular',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: onInfoPressed,
          tooltip: 'Informações da Grade',
        ),
      ],
    );
  }
}