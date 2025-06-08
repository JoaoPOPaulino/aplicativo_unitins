import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/RematriculaProvider.dart';

class ComprovanteMatriculaScreen extends StatelessWidget {
  final int userId;

  const ComprovanteMatriculaScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final rematriculaProvider = Provider.of<RematriculaProvider>(context);
    final disciplinasSelecionadas = rematriculaProvider.getDisciplinas();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comprovante de Matrícula'),
        backgroundColor: Colors.blue[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Dados do Aluno',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Nome: ${rematriculaProvider.getUserName(userId) ?? "Usuário"}'),
            Text('Matrícula: 2021TI0100${userId}387'),
            Text('Curso: Sistemas de Informação'),
            Text('Semestre: 2º Semestre de 2025'),
            const Divider(),
            Text(
              'Disciplinas Matriculadas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...disciplinasSelecionadas.map((disciplina) => ListTile(
              title: Text(disciplina.disciplina),
              subtitle: Text('Carga Horária: ${disciplina.cargaHoraria}h'),
              trailing: Text('Matriculado'),
            )),
            const Divider(),
            Text(
              'Data de Solicitação: ${DateTime.now().toString().split('.')[0]}',
              textAlign: TextAlign.right,
            ),
            Text(
              'Acesso para validação: https://www.unitins.br/SVD',
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}