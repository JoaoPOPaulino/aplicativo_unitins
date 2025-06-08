import 'package:flutter/material.dart';
import '../models/Disciplina.dart';
import '../services/AnaliseCurricularService.dart';

class AnaliseCurricularProvider with ChangeNotifier {
  final AnaliseCurricularService _service = AnaliseCurricularService();
  double _progresso = 0.0;
  List<Disciplina> _disciplinasConcluidas = [];
  List<Disciplina> _disciplinasPendentes = [];

  double get progresso => _progresso;
  List<Disciplina> get disciplinasConcluidas => _disciplinasConcluidas;
  List<Disciplina> get disciplinasPendentes => _disciplinasPendentes;

  Future<void> fetchAnalise(int userId) async {
    try {
      final (concluidas, pendentes) = await _service.fetchAnalise(userId);
      _disciplinasConcluidas = concluidas;
      _disciplinasPendentes = pendentes;
      _progresso = (_disciplinasConcluidas.length / 67) * 100; // Total de disciplinas = 67
      notifyListeners();
    } catch (e) {
      print('Erro ao carregar análise: $e');
    }
  }
}