import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/Boletim.dart';
import '../models/Disciplina.dart';
import '../models/Situacao.dart';
import '../services/AnaliseCurricularService.dart';
import '../services/UserService.dart';

class AnaliseCurricularProvider with ChangeNotifier {
  final AnaliseCurricularService _service = AnaliseCurricularService();
  final UserService _userService = UserService();
  double _progresso = 0.0;
  List<Disciplina> _disciplinasConcluidas = [];
  List<Disciplina> _disciplinasPendentes = [];
  int? _periodoAtual;

  List<Boletim> _boletim = [];

  List<Boletim> get boletim => _boletim;

  double get progresso => _progresso;
  List<Disciplina> get disciplinasConcluidas => _disciplinasConcluidas;
  List<Disciplina> get disciplinasPendentes => _disciplinasPendentes;
  int? get periodoAtual => _periodoAtual;

  Future<void> fetchAnalise(int userId) async {
    try {
      final (concluidas, pendentes) = await _service.fetchAnalise(userId);
      _disciplinasConcluidas = concluidas;
      _disciplinasPendentes = pendentes;

      // Calcular progresso com base na carga horária
      final totalCargaHoraria = (_disciplinasConcluidas + _disciplinasPendentes).fold(0, (sum, d) => sum + d.cargaHoraria);
      final cargaHorariaConcluida = _disciplinasConcluidas.fold(0, (sum, d) => sum + d.cargaHoraria);
      _progresso = totalCargaHoraria > 0 ? (cargaHorariaConcluida / totalCargaHoraria) * 100 : 0.0;

      // Buscar período atual
      final situacaoResponse = await http.get(Uri.parse('http://localhost:3000/situacao?userId=$userId')).timeout(const Duration(seconds: 30));
      if (situacaoResponse.statusCode == 200) {
        final situacaoData = jsonDecode(situacaoResponse.body) as List;
        if (situacaoData.isNotEmpty) {
          _periodoAtual = Situacao.fromJson(situacaoData.first).periodoAtual;
        }
      }

      notifyListeners();
    } catch (e) {
      print('Erro ao carregar análise: $e');
    }
  }
}