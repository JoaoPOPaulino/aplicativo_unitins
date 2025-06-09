import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/RematriculaProvider.dart';

class AlunoInfoSection extends StatelessWidget {
  final int userId;

  const AlunoInfoSection({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final rematriculaProvider = Provider.of<RematriculaProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Dados do Aluno',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text('Nome: ${rematriculaProvider.getUserName(userId) ?? "Usuário"}'),
        Text('Matrícula: 2021TI0100${userId}387'),
        Text('Curso: Sistemas de Informação'),
        Text('Semestre: 2º Semestre de 2025'),
        const Divider(),
      ],
    );
  }
}