import 'package:flutter/material.dart';

class ProgressoCard extends StatelessWidget {
  final double progresso;

  const ProgressoCard({
    super.key,
    required this.progresso,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Progresso do Curso',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progresso / 100,
          backgroundColor: Colors.grey[300],
          color: Colors.blue[700],
          minHeight: 10,
        ),
        const SizedBox(height: 8),
        Text(
          'Progresso: ${progresso.toStringAsFixed(1)}%',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}