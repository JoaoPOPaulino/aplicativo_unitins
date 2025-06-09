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
    return ListTile(
      title: Text(disciplina.disciplina),
      subtitle: Text('Carga Horária: ${disciplina.cargaHoraria}h'),
    );
  }
}