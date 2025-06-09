import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/Boletim.dart';
import '../../provider/BoletimProvider.dart';
import 'BoletimAppBar.dart';
import 'BoletimEmptyState.dart';
import 'BoletimErrorState.dart';
import 'BoletimLoadingState.dart';
import 'BoletimSummaryCard.dart';
import 'DisciplinaCard.dart';

class BoletimScreen extends StatelessWidget {
  const BoletimScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: const BoletimAppBar(),
      body: Consumer<BoletimProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const BoletimLoadingState();
          }

          if (provider.error != null) {
            return BoletimErrorState(
              error: provider.error!,
              onRetry: provider.fetchBoletim,
            );
          }

          if (provider.boletim.isEmpty) {
            return const BoletimEmptyState();
          }

          return _buildBoletimContent(context, provider.boletim);
        },
      ),
    );
  }

  Widget _buildBoletimContent(BuildContext context, List<Boletim> boletim) {
    final aprovadas = boletim.where((b) => b.status == 'Aprovado').length;
    final reprovadas = boletim.where((b) => b.status == 'Reprovado').length;
    final mediaGeral = boletim.isNotEmpty
        ? boletim.map((b) => b.nota).reduce((a, b) => a + b) / boletim.length
        : 0.0;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: BoletimSummaryCard(
                  title: 'Média Geral',
                  value: mediaGeral.toStringAsFixed(1),
                  icon: Icons.trending_up,
                  color: mediaGeral >= 6 ? Colors.green : Colors.red,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: BoletimSummaryCard(
                  title: 'Aprovadas',
                  value: aprovadas.toString(),
                  icon: Icons.check_circle,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: BoletimSummaryCard(
                  title: 'Reprovadas',
                  value: reprovadas.toString(),
                  icon: Icons.cancel,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: ListView.separated(
              itemCount: boletim.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return DisciplinaCard(item: boletim[index]);
              },
            ),
          ),
        ),
      ],
    );
  }
}