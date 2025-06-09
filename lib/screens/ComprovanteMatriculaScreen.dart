import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/RematriculaProvider.dart';
import '../widgets/analiseCurricular/DisciplinasList.dart';
import '../widgets/comprovante/AlunoInfoSection.dart';
import '../widgets/comprovante/ComprovanteAppBar.dart';
import '../widgets/comprovante/FooterSection.dart';

class ComprovanteMatriculaScreen extends StatelessWidget {
  final int userId;

  const ComprovanteMatriculaScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final rematriculaProvider = Provider.of<RematriculaProvider>(context);
    final disciplinasSelecionadas = rematriculaProvider.getDisciplinas();

    return Scaffold(
      appBar: const ComprovanteAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            AlunoInfoSection(userId: userId),
            DisciplinasList(
              titulo: 'Disciplinas Matriculadas',
              disciplinas: disciplinasSelecionadas,
            ),
            const FooterSection(),
          ],
        ),
      ),
    );
  }
}