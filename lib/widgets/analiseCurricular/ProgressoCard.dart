import 'package:flutter/material.dart';

class ProgressoCard extends StatelessWidget {
  final double progresso;

  const ProgressoCard({super.key, required this.progresso});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Progresso do Curso',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progresso / 100,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            const SizedBox(height: 8),
            Text('${progresso.toStringAsFixed(2)}% concluído'),
          ],
        ),
      ),
    );
  }
}