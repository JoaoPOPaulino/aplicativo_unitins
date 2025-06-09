import 'package:flutter/material.dart';
import '../../models/Disciplina.dart';
import 'DisciplinaCheckboxCard.dart';

class DisciplinasRematriculaList extends StatelessWidget {
  final String titulo;
  final List<Disciplina> disciplinas;
  final List<Disciplina> selecionadas;
  final ValueChanged<Disciplina> onToggleDisciplina;

  const DisciplinasRematriculaList({
    super.key,
    required this.titulo,
    required this.disciplinas,
    required this.selecionadas,
    required this.onToggleDisciplina,
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
        ...disciplinas.map((disciplina) => DisciplinaCheckboxCard(
          disciplina: disciplina,
          isSelected: selecionadas.contains(disciplina),
          onChanged: (_) => onToggleDisciplina(disciplina),
        )),
        const Divider(),
      ],
    );
  }
}