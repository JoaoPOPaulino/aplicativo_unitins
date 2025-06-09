import 'package:flutter/material.dart';

class LoadingErrorState extends StatelessWidget {
  final String? error;

  const LoadingErrorState({
    super.key,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      return Center(child: Text('Erro: $error'));
    }
    return const Center(child: CircularProgressIndicator());
  }
}