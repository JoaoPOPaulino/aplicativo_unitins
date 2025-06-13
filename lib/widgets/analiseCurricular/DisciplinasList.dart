import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/Boletim.dart';
import '../../models/Disciplina.dart';
import '../../provider/AnaliseCurricularProvider.dart';

class DisciplinasList extends StatelessWidget {
  final String titulo;
  final List<Disciplina> disciplinas;

  const DisciplinasList({super.key, required this.titulo, required this.disciplinas});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AnaliseCurricularProvider>(context);
    final boletim = provider.boletim;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (titulo.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              titulo,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        disciplinas.isEmpty
            ? const Text('Nenhuma disciplina encontrada.')
            : ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: disciplinas.length,
          itemBuilder: (context, index) {
            final disciplina = disciplinas[index];

            final boletimItem = boletim.firstWhere(
                  (b) => b.disciplinaId == disciplina.id,
              orElse: () => Boletim(
                id: 0,
                userId: 0,
                disciplinaId: disciplina.id,
                disciplina: disciplina.disciplina,
                periodo: disciplina.periodo,
                nota: 0,
                frequencia: '0%',
                status: 'Pendente',
                semestreConclusao: null,
              ),
            );

            final isConcluida = boletimItem.status != 'Pendente';
            final cardColor = isConcluida
                ? Colors.green[50]
                : Colors.orange[50];
            final icon = isConcluida
                ? const Icon(Icons.check_circle, color: Colors.green)
                : const Icon(Icons.schedule, color: Colors.orange);

            return Card(
              color: cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                leading: icon,
                title: Text(
                  disciplina.disciplina,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Período: ${disciplina.periodo} | Carga Horária: ${disciplina.cargaHoraria}h',
                    ),
                    if (isConcluida) ...[
                      const SizedBox(height: 4),
                      Text('Nota: ${boletimItem.nota.toStringAsFixed(1)}'),
                      Text('Frequência: ${boletimItem.frequencia}'),
                      Text('Status: ${boletimItem.status}'),
                      if (boletimItem.semestreConclusao != null)
                        Text('Concluído em: ${boletimItem.semestreConclusao}'),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
