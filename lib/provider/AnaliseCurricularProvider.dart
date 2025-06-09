import 'package:flutter/material.dart';
import '../models/Disciplina.dart';
import '../services/AnaliseCurricularService.dart';
import '../services/UserService.dart';

class AnaliseCurricularProvider with ChangeNotifier {
  final AnaliseCurricularService _service = AnaliseCurricularService();
  final UserService _userService = UserService();
  double _progresso = 0.0;
  List<Disciplina> _disciplinasConcluidas = [];
  List<Disciplina> _disciplinasPendentes = [];
  int? _periodoAtual;

  double get progresso => _progresso;
  List<Disciplina> get disciplinasConcluidas => _disciplinasConcluidas;
  List<Disciplina> get disciplinasPendentes => _disciplinasPendentes;
  int? get periodoAtual => _periodoAtual;

  Future<void> fetchAnalise(int userId) async {
    try {
      final (concluidas, pendentes) = await _service.fetchAnalise(userId);
      _disciplinasConcluidas = concluidas;
      _disciplinasPendentes = pendentes;
      final totalDisciplinas = _disciplinasConcluidas.length + _disciplinasPendentes.length;
      _progresso = totalDisciplinas > 0 ? (_disciplinasConcluidas.length / totalDisciplinas) * 100 : 0.0;

      // Buscar período atual
      final user = await _userService.fetchUser(userId);
      _periodoAtual = user?.periodoAtual;

      notifyListeners();
    } catch (e) {
      print('Erro ao carregar análise: $e');
    }
  }
}