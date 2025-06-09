import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Disciplina.dart';
import '../provider/RematriculaProvider.dart';
import '../services/GradeCurricularService.dart';
import '../widgets/rematricula/DisciplinasRematriculaList.dart';
import '../widgets/rematricula/LoadingErrorState.dart';
import '../widgets/rematricula/RematriculaAppBar.dart';
import '../widgets/rematricula/SaveButton.dart';
import 'ComprovanteMatriculaScreen.dart';

class RematriculaScreen extends StatefulWidget {
  final int userId;

  const RematriculaScreen({super.key, required this.userId});

  @override
  _RematriculaScreenState createState() => _RematriculaScreenState();
}

class _RematriculaScreenState extends State<RematriculaScreen> {
  final GradeCurricularService _gradeService = GradeCurricularService();
  late Future<List<Disciplina>> _gradeFuture;
  List<Disciplina> _disciplinasSelecionadas = [];

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<RematriculaProvider>(context, listen: false);
    provider.setUserId(widget.userId);
    _gradeFuture = _loadGrade(provider);
  }

  Future<List<Disciplina>> _loadGrade(RematriculaProvider provider) async {
    final curso = provider.curso ?? 'Sistemas de Informação';
    return _gradeService.fetchGradeCurricular(curso);
  }

  void _toggleDisciplina(Disciplina disciplina) {
    setState(() {
      if (_disciplinasSelecionadas.contains(disciplina)) {
        _disciplinasSelecionadas.remove(disciplina);
      } else {
        _disciplinasSelecionadas.add(disciplina);
      }
    });
  }

  void _salvarRematricula() {
    if (_disciplinasSelecionadas.isNotEmpty) {
      final provider = Provider.of<RematriculaProvider>(context, listen: false);
      provider.setDisciplinas(_disciplinasSelecionadas);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Rematrícula salva com sucesso!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ComprovanteMatriculaScreen(userId: widget.userId),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione pelo menos uma disciplina!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RematriculaProvider>(context);
    final proximoPeriodo = (provider.periodoAtual ?? 1) + 1;

    if (provider.isMatriculado(proximoPeriodo)) {
      return ComprovanteMatriculaScreen(userId: widget.userId);
    }

    return Scaffold(
      appBar: const RematriculaAppBar(),
      body: FutureBuilder<List<Disciplina>>(
        future: _gradeFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const LoadingErrorState();
          }
          if (snapshot.hasError) {
            return LoadingErrorState(error: snapshot.error.toString());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const LoadingErrorState(error: 'Nenhuma disciplina encontrada');
          }

          final disciplinas = snapshot.data!
              .where((d) => d.periodo == proximoPeriodo)
              .toList();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Selecione as disciplinas para o ${proximoPeriodo}º Semestre de 2025:',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                DisciplinasRematriculaList(
                  titulo: 'Selecione as disciplinas para o ${proximoPeriodo}º Semestre de 2025:',
                  disciplinas: disciplinas,
                  selecionadas: _disciplinasSelecionadas,
                  onToggleDisciplina: _toggleDisciplina,
                ),
                const SizedBox(height: 16),
                SaveButton(onPressed: _salvarRematricula),
              ],
            ),
          );
        },
      ),
    );
  }
}