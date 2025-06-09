import 'package:flutter/material.dart';

import '../../models/Disciplina.dart';
import 'DisciplinaItem.dart';


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
        Expanded(
          child: ListView.builder(
            itemCount: disciplinas.length,
            itemBuilder: (context, index) {
              return DisciplinaItem(disciplina: disciplinas[index]);
            },
          ),
        ),
      ],
    );
  }
}