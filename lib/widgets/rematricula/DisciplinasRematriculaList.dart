import 'package:flutter/material.dart';
import '../../models/Disciplina.dart';
import 'DisciplinaCheckboxCard.dart';

class DisciplinasRematriculaList extends StatelessWidget {
  final String titulo;
  final List<Disciplina> disciplinas;
  final List<Disciplina> selecionadas;
  final Function(Disciplina) onToggleDisciplina;

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
      children: disciplinas.map((disciplina) {
        final selecionada = selecionadas.contains(disciplina);

        return Card(
          color: selecionada ? Colors.green[50] : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: selecionada ? Colors.green : Colors.grey.shade300,
              width: 1,
            ),
          ),
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            leading: Icon(
              selecionada ? Icons.check_circle : Icons.circle_outlined,
              color: selecionada ? Colors.green : Colors.grey,
            ),
            title: Text(
              disciplina.disciplina,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              'Período: ${disciplina.periodo} | Carga Horária: ${disciplina.cargaHoraria}h',
              style: const TextStyle(fontSize: 13),
            ),
            onTap: () => onToggleDisciplina(disciplina),
          ),
        );
      }).toList(),
    );
  }
}
