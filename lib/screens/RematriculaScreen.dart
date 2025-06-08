import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Disciplina.dart';
import '../provider/RematriculaProvider.dart';
import '../services/GradeCurricularService.dart';
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
  late int _proximoPeriodo = 2; // Próximo período após o 1º semestre de 2025
  List<Disciplina> _disciplinasSelecionadas = [];

  @override
  void initState() {
    super.initState();
    _gradeFuture = _gradeService.fetchGradeCurricular('Sistemas de Informação');
  }

  void _salvarRematricula() {
    if (_disciplinasSelecionadas.isNotEmpty) {
      final provider = Provider.of<RematriculaProvider>(context, listen: false);
      provider.setDisciplinas(_disciplinasSelecionadas);
      provider.setUserId(widget.userId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Rematrícula salva com sucesso!')),
      );
      // Navegar para o comprovante
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rematrícula Online'),
        backgroundColor: Colors.blue[700],
      ),
      body: FutureBuilder<List<Disciplina>>(
        future: _gradeFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma disciplina encontrada'));
          }

          final disciplinas = snapshot.data!
              .where((d) => d.periodo == _proximoPeriodo)
              .toList();

          // Simulação: Se já há matrícula ativa para o próximo período, exibe o comprovante
          final situacaoProvider = Provider.of<RematriculaProvider>(context);
          if (situacaoProvider.isMatriculado(_proximoPeriodo)) {
            return ComprovanteMatriculaScreen(userId: widget.userId);
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  'Selecione as disciplinas para o 2º Semestre de 2025:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: disciplinas.length,
                    itemBuilder: (context, index) {
                      final disciplina = disciplinas[index];
                      final isSelected = _disciplinasSelecionadas.contains(disciplina);
                      return Card(
                        child: ListTile(
                          title: Text(disciplina.disciplina),
                          subtitle: Text('Carga Horária: ${disciplina.cargaHoraria}h'),
                          trailing: Checkbox(
                            value: isSelected,
                            onChanged: (value) {
                              setState(() {
                                if (value!) {
                                  _disciplinasSelecionadas.add(disciplina);
                                } else {
                                  _disciplinasSelecionadas.remove(disciplina);
                                }
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _salvarRematricula,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[600],
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Salvar Rematrícula'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}