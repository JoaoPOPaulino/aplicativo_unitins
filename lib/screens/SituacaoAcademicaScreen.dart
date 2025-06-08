import 'package:flutter/material.dart';

import '../models/Situacao.dart';
import '../services/SituacaoService.dart';


class SituacaoAcademicaScreen extends StatefulWidget {
  final int userId; // Recebe o ID do usuário logado

  const SituacaoAcademicaScreen({super.key, required this.userId});

  @override
  _SituacaoAcademicaScreenState createState() => _SituacaoAcademicaScreenState();
}

class _SituacaoAcademicaScreenState extends State<SituacaoAcademicaScreen> {
  final SituacaoService _service = SituacaoService();
  late Future<Situacao?> _situacaoFuture;

  @override
  void initState() {
    super.initState();
    _situacaoFuture = _service.fetchSituacao(widget.userId);
  }

  void _reloadSituacao() {
    setState(() {
      _situacaoFuture = _service.fetchSituacao(widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Situação Acadêmica'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<Situacao?>(
          future: _situacaoFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Carregando situação acadêmica...'),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red, size: 48),
                    const SizedBox(height: 16),
                    Text(
                      'Erro: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _reloadSituacao,
                      child: const Text('Tentar Novamente'),
                    ),
                  ],
                ),
              );
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Center(
                child: Text(
                  'Nenhuma informação encontrada',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
            }

            final situacao = snapshot.data!;
            return ListView(
              children: [
                _buildStatusCard(
                  title: 'Status da Matrícula',
                  content: situacao.matriculaStatus,
                  icon: Icons.school,
                  color: situacao.matriculaStatus == 'Ativa' ? Colors.green : Colors.red,
                ),
                const SizedBox(height: 16),
                _buildStatusCard(
                  title: 'Documentos Pendentes',
                  content: situacao.documentosPendentes.isEmpty
                      ? 'Nenhum documento pendente'
                      : situacao.documentosPendentes.join(', '),
                  icon: Icons.description,
                  color: situacao.documentosPendentes.isEmpty ? Colors.green : Colors.orange,
                ),
                const SizedBox(height: 16),
                _buildStatusCard(
                  title: 'Pendências Financeiras',
                  content: situacao.pendenciasFinanceiras.isEmpty
                      ? 'Nenhuma pendência'
                      : situacao.pendenciasFinanceiras,
                  icon: Icons.account_balance_wallet,
                  color: situacao.pendenciasFinanceiras.isEmpty ? Colors.green : Colors.red,
                ),
                const SizedBox(height: 16),
                _buildStatusCard(
                  title: 'Pendências Acadêmicas',
                  content: situacao.pendenciasAcademicas.isEmpty
                      ? 'Nenhuma pendência'
                      : situacao.pendenciasAcademicas,
                  icon: Icons.book,
                  color: situacao.pendenciasAcademicas.isEmpty ? Colors.green : Colors.red,
                ),
                const SizedBox(height: 16),
                _buildStatusCard(
                  title: 'Última Atualização',
                  content: situacao.ultimaAtualizacao,
                  icon: Icons.calendar_today,
                  color: Colors.blue,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatusCard({
    required String title,
    required String content,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    content,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}