import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Data de Solicitação: ${DateTime.now().toString().split('.')[0]}',
          textAlign: TextAlign.right,
        ),
        Text(
          'Acesso para validação: https://www.unitins.br/SVD',
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}