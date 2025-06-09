import 'package:flutter/material.dart';
import '../../models/Disciplina.dart';

class DisciplinaItem extends StatelessWidget {
  final Disciplina disciplina;

  const DisciplinaItem({
    super.key,
    required this.disciplina,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      elevation: 1,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: const Icon(Icons.book, color: Colors.blue),
        title: Text(
          disciplina.disciplina,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Carga Horária: ${disciplina.cargaHoraria}h'),
            Text('Código: ${disciplina.id}'),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.green[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.green),
          ),
          child: const Text(
            'Matriculado',
            style: TextStyle(color: Colors.green),
          ),
        ),
      ),
    );
  }
}