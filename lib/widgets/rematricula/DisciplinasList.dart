import 'package:flutter/material.dart';
import '../../models/Disciplina.dart';
import 'DisciplinaCheckboxCard.dart';

class DisciplinasList extends StatelessWidget {
  final List<Disciplina> disciplinas;
  final List<Disciplina> selecionadas;
  final ValueChanged<Disciplina> onToggleDisciplina;

  const DisciplinasList({
    super.key,
    required this.disciplinas,
    required this.selecionadas,
    required this.onToggleDisciplina,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: disciplinas.length,
        itemBuilder: (context, index) {
          final disciplina = disciplinas[index];
          return DisciplinaCheckboxCard(
            disciplina: disciplina,
            isSelected: selecionadas.contains(disciplina),
            onChanged: (value) => onToggleDisciplina(disciplina),
          );
        },
      ),
    );
  }
}