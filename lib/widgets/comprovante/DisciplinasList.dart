import 'package:flutter/material.dart';
import '../../models/Disciplina.dart';
import '../analiseCurricular/DisciplinaItem.dart';

class DisciplinasList extends StatelessWidget {
  final String titulo;
  final List<Disciplina> disciplinas;

  const DisciplinasList({
    super.key,
    required this.titulo,
    required this.disciplinas,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...disciplinas.map((disciplina) => DisciplinaItem(disciplina: disciplina)),
        const Divider(),
      ],
    );
  }
}