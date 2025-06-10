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
        Text(
          titulo,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
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
                periodo: disciplina.periodo, // Adicionado
                nota: 0,
                frequencia: '0%',
                status: 'Pendente',
                semestreConclusao: null,
              ),
            );

            return Card(
              child: ListTile(
                title: Text(disciplina.disciplina),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Período: ${disciplina.periodo} | Carga Horária: ${disciplina.cargaHoraria}h'),
                    if (boletimItem.status != 'Pendente') ...[
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