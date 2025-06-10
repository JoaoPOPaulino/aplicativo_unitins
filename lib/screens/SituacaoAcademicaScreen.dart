import 'package:flutter/material.dart';

import '../models/Situacao.dart';
import '../services/SituacaoService.dart';
import '../widgets/situacaoAcademica/EmptyStateWidget.dart';
import '../widgets/situacaoAcademica/ErrorWidget.dart' as custom_error;
import '../widgets/situacaoAcademica/LoadingWidget.dart';
import '../widgets/situacaoAcademica/StatusCard.dart';

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
              return const LoadingWidget(
                message: 'Carregando situação acadêmica...',
              );
            } else if (snapshot.hasError) {
              return custom_error.ErrorWidget(
                errorMessage: snapshot.error.toString(),
                onRetry: _reloadSituacao,
              );
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const EmptyStateWidget(
                message: 'Nenhuma informação encontrada',
                icon: Icons.school_outlined,
              );
            }

            final situacao = snapshot.data!;
            return ListView(
              children: [
                StatusCard(
                  title: 'Status da Matrícula',
                  content: situacao.matriculaStatus,
                  icon: Icons.school,
                  color: situacao.matriculaStatus == 'Ativa' ? Colors.green : Colors.red,
                ),
                const SizedBox(height: 16),
                StatusCard(
                  title: 'Documentos Pendentes',
                  content: situacao.documentosPendentes.isEmpty
                      ? 'Nenhum documento pendente'
                      : situacao.documentosPendentes.join(', '),
                  icon: Icons.description,
                  color: situacao.documentosPendentes.isEmpty ? Colors.green : Colors.orange,
                ),
                const SizedBox(height: 16),
                StatusCard(
                  title: 'Pendências Financeiras',
                  content: situacao.pendenciasFinanceiras.isEmpty
                      ? 'Nenhuma pendência'
                      : situacao.pendenciasFinanceiras,
                  icon: Icons.account_balance_wallet,
                  color: situacao.pendenciasFinanceiras.isEmpty ? Colors.green : Colors.red,
                ),
                const SizedBox(height: 16),
                StatusCard(
                  title: 'Pendências Acadêmicas',
                  content: situacao.pendenciasAcademicas.isEmpty
                      ? 'Nenhuma pendência'
                      : situacao.pendenciasAcademicas,
                  icon: Icons.book,
                  color: situacao.pendenciasAcademicas.isEmpty ? Colors.green : Colors.red,
                ),
                const SizedBox(height: 16),
                StatusCard(
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
}