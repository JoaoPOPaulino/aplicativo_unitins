import 'package:flutter/material.dart';
import '../../models/Disciplina.dart';

class DisciplinaCheckboxCard extends StatelessWidget {
  final Disciplina disciplina;
  final bool isSelected;
  final ValueChanged<bool?> onChanged;

  const DisciplinaCheckboxCard({
    super.key,
    required this.disciplina,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text(disciplina.disciplina),
        subtitle: Text('Carga Horária: ${disciplina.cargaHoraria}h'),
        trailing: Checkbox(
          value: isSelected,
          onChanged: onChanged,
        ),
      ),
    );
  }
}