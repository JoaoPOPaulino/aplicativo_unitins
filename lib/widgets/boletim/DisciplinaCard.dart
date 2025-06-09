import 'package:flutter/material.dart';
import '../../models/Boletim.dart';
import 'InfoItem.dart';

class DisciplinaCard extends StatelessWidget {
  final Boletim item;

  const DisciplinaCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = item.status == 'Aprovado'
        ? Colors.green
        : item.status == 'Reprovado'
        ? Colors.red
        : Colors.orange;

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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.disciplina,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: statusColor.withOpacity(0.3)),
                  ),
                  child: Text(
                    item.status,
                    style: TextStyle(
                      fontSize: 12,
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: InfoItem(
                    label: 'Nota',
                    value: item.nota.toStringAsFixed(1),
                    icon: Icons.grade,
                    color: item.nota >= 6 ? Colors.green : Colors.red,
                  ),
                ),
                Expanded(
                  child: InfoItem(
                    label: 'Frequência',
                    value: item.frequencia,
                    icon: Icons.access_time,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}