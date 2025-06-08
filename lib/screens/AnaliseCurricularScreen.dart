import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Disciplina.dart';
import '../provider/AnaliseCurricularProvider.dart';

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
      appBar: AppBar(
        title: const Text('Análise Curricular'),
        backgroundColor: Colors.blue[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Progresso do Curso',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progresso / 100,
              backgroundColor: Colors.grey[300],
              color: Colors.blue[700],
              minHeight: 10,
            ),
            const SizedBox(height: 8),
            Text(
              'Progresso: ${progresso.toStringAsFixed(1)}%',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Disciplinas Concluídas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: disciplinasConcluidas.length,
                itemBuilder: (context, index) {
                  final disciplina = disciplinasConcluidas[index];
                  return ListTile(
                    title: Text(disciplina.disciplina),
                    subtitle: Text('Carga Horária: ${disciplina.cargaHoraria}h'),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Disciplinas Pendentes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: disciplinasPendentes.length,
                itemBuilder: (context, index) {
                  final disciplina = disciplinasPendentes[index];
                  return ListTile(
                    title: Text(disciplina.disciplina),
                    subtitle: Text('Carga Horária: ${disciplina.cargaHoraria}h'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}