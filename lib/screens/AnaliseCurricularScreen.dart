import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/AnaliseCurricularProvider.dart';
import '../widgets/analiseCurricular/AnaliseAppBar.dart';
import '../widgets/analiseCurricular/DisciplinasList.dart';
import '../widgets/analiseCurricular/ProgressoCard.dart';

class AnaliseCurricularScreen extends StatefulWidget {
  final int userId;

  const AnaliseCurricularScreen({super.key, required this.userId});

  @override
  _AnaliseCurricularScreenState createState() => _AnaliseCurricularScreenState();
}

class _AnaliseCurricularScreenState extends State<AnaliseCurricularScreen> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<AnaliseCurricularProvider>(context, listen: false);
    provider.fetchAnalise(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AnaliseCurricularProvider>(context);
    final progresso = provider.progresso;
    final disciplinasConcluidas = provider.disciplinasConcluidas;
    final disciplinasPendentes = provider.disciplinasPendentes;

    return Scaffold(
      appBar: const AnaliseAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProgressoCard(progresso: progresso),
            const SizedBox(height: 16),
            DisciplinasList(
              titulo: 'Disciplinas Concluídas',
              disciplinas: disciplinasConcluidas,
            ),
            const SizedBox(height: 16),
            DisciplinasList(
              titulo: 'Disciplinas Pendentes',
              disciplinas: disciplinasPendentes,
            ),
          ],
        ),
      ),
    );
  }
}