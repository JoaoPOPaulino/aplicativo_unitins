import 'package:flutter/material.dart';

class GradeInfoDialog extends StatelessWidget {
  const GradeInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: const Row(
        children: [
          Icon(Icons.info, color: Colors.blue),
          SizedBox(width: 8),
          Text('Informações da Grade'),
        ],
      ),
      content: const Text(
        'Esta grade curricular apresenta todas as disciplinas organizadas por período. '
            'As disciplinas optativas são exibidas separadamente e podem ser cursadas '
            'em qualquer período adequado.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Entendi'),
        ),
      ],
    );
  }
}