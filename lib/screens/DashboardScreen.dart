import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/BoletimProvider.dart';
import 'AnaliseCurricularScreen.dart';
import 'BoletimScreen.dart';
import 'GradeCurricularScreen.dart';
import 'LoginScreen.dart';
import 'RematriculaScreen.dart';
import 'SituacaoAcademicaScreen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key, required this.userId});

  final int userId;

  final List<Map<String, String>> cards = const [
    {
      'title': 'BOLETIM (SEMESTRE ATUAL)',
      'description': 'Desempenho nas disciplinas do semestre atual'
    },
    {
      'title': 'GRADE CURRICULAR',
      'description': 'Selecione um curso e veja as disciplinas distribuídas por período.'
    },
    {
      'title': 'REMATRÍCULA ONLINE',
      'description': 'Fazer a rematrícula nos semestres posteriores, conforme calendário acadêmico. Emissão da declaração de vínculo.'
    },
    {
      'title': 'SITUAÇÃO ACADÊMICA',
      'description': 'Veja a sua situação junto à secretaria e demais departamentos da unitins.'
    },
    {
      'title': 'ANÁLISE CURRICULAR',
      'description': 'Análise curricular completa'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Secretaria'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Sair'),
                  content: const Text('Deseja realmente sair?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                        );
                      },
                      child: const Text(
                        'Sair',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
          children: cards.map((card) {
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: Colors.blue[300]!,
                  width: 2,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white,
                      Colors.blue[50]!,
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              card['title']!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.blue[800],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Expanded(
                              child: Text(
                                card['description']!,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {
                            if (card['title'] == 'BOLETIM (SEMESTRE ATUAL)') {
                              final provider = Provider.of<BoletimProvider>(context, listen: false);
                              provider.setUserId(userId);
                              provider.fetchBoletim();
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const BoletimScreen()),
                              );
                            } else if (card['title'] == 'GRADE CURRICULAR') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const GradeCurricularScreen()),
                              );
                            } else if (card['title'] == 'SITUAÇÃO ACADÊMICA') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SituacaoAcademicaScreen(userId: userId),
                                ),
                              );
                            } else if (card['title'] == 'REMATRÍCULA ONLINE') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => RematriculaScreen(userId: userId),
                                ),
                              );
                            } else if (card['title'] == 'ANÁLISE CURRICULAR') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AnaliseCurricularScreen(userId: userId),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[600],
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            elevation: 2,
                          ),
                          child: const Text(
                            'Acessar',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}