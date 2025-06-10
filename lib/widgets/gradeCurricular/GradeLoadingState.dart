import 'package:flutter/material.dart';

class GradeLoadingState extends StatelessWidget {
  const GradeLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(strokeWidth: 3),
          SizedBox(height: 24),
          Text(
            'Carregando grade curricular...',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}