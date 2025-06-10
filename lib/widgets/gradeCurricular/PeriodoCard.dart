import 'package:flutter/material.dart';
import '../../models/Disciplina.dart';
import '../analiseCurricular/DisciplinaItem.dart';

class PeriodoCard extends StatelessWidget {
  final int periodo;
  final List<Disciplina> disciplinas;
  final Color primaryColor;

  const PeriodoCard({
    super.key,
    required this.periodo,
    required this.disciplinas,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final cargaHorariaPeriodo = disciplinas.fold<int>(
      0,
          (sum, disciplina) => sum + disciplina.cargaHoraria,
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        childrenPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: periodo == 0
                    ? Colors.orange.withOpacity(0.1)
                    : primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                periodo == 0 ? Icons.star_outline : Icons.calendar_today,
                color: periodo == 0 ? Colors.orange : primaryColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    periodo == 0 ? 'Disciplinas Optativas' : '${periodo}º Período',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${disciplinas.length} disciplinas • ${cargaHorariaPeriodo}h',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        children: disciplinas
            .map((disciplina) => DisciplinaItem(disciplina: disciplina))
            .toList(),
      ),
    );
  }
}