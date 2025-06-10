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
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<AnaliseCurricularProvider>(context, listen: false);
    provider.fetchAnalise(widget.userId).catchError((e) {
      setState(() {
        _errorMessage = 'Erro ao carregar dados: $e';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar dados: $e')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AnaliseCurricularProvider>(context);
    final progresso = provider.progresso;
    final disciplinasConcluidas = provider.disciplinasConcluidas;
    final disciplinasPendentes = provider.disciplinasPendentes;
    final periodoAtual = provider.periodoAtual;

    if (_errorMessage != null) {
      return Scaffold(
        appBar: const AnaliseAppBar(),
        body: Center(child: Text(_errorMessage!, style: const TextStyle(color: Colors.red))),
      );
    }

    return Scaffold(
      appBar: const AnaliseAppBar(),
      body: provider.progresso == 0.0 && disciplinasConcluidas.isEmpty && disciplinasPendentes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Período Atual: ${periodoAtual != null ? "$periodoAtualº período" : "Não disponível"}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
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