import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/BoletimProvider.dart';

class BoletimAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  const BoletimAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Boletim Acadêmico',
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
        Consumer<BoletimProvider>(
          builder: (context, provider, child) => IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: provider.isLoading ? null : provider.fetchBoletim,
            tooltip: 'Atualizar',
          ),
        ),
      ],
    );
  }
}