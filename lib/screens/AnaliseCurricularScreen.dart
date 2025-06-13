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
            // Período Atual em destaque
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.blue),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Período Atual: ${periodoAtual != null ? "$periodoAtualº período" : "Não disponível"}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Progresso com mais visual
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Progresso do Curso",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: progresso,
                      backgroundColor: Colors.grey[300],
                      color: Colors.blue[700],
                      minHeight: 10,
                    ),
                    const SizedBox(height: 6),
                    Text("${(progresso * 100).toStringAsFixed(1)}% concluído"),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Disciplinas Concluídas
            Text('✅ Disciplinas Concluídas',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            disciplinasConcluidas.isEmpty
                ? const Text("Nenhuma disciplina encontrada.")
                : DisciplinasList(
              titulo: '',
              disciplinas: disciplinasConcluidas,
            ),

            const SizedBox(height: 24),

            // Disciplinas Pendentes
            Text('📚 Disciplinas Pendentes',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            DisciplinasList(
              titulo: '',
              disciplinas: disciplinasPendentes,
            ),
          ],
        ),
      ),
    );
  }
}