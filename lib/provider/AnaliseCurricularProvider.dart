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
      // Buscar boletim
      final boletimResponse = await http.get(Uri.parse('http://localhost:3000/boletim?userId=$userId')).timeout(const Duration(seconds: 30));
      if (boletimResponse.statusCode == 200) {
        final boletimData = jsonDecode(boletimResponse.body) as List;

        // Buscar grade curricular para mapear disciplinaId para nome e período
        final gradeResponse = await http.get(Uri.parse('http://localhost:3000/grade_curricular')).timeout(const Duration(seconds: 30));
        if (gradeResponse.statusCode == 200) {
          final gradeData = jsonDecode(gradeResponse.body) as List<dynamic>;
          final disciplinaMap = {
            for (var item in gradeData)
              int.parse(item['id'].toString()): {
                'nome': item['disciplina'].toString(),
                'periodo': int.parse(item['periodo'].toString()),
              }
          };

          // Mapear boletim com nomes e períodos das disciplinas
          _boletim = boletimData.map((json) {
            final disciplinaId = int.parse(json['disciplinaId']?.toString() ?? '0');
            final disciplinaInfo = disciplinaMap[disciplinaId] ?? {
              'nome': 'Disciplina não encontrada',
              'periodo': 0,
            };
            return Boletim.fromJson(
              json,
              disciplinaInfo['nome'] as String,
              disciplinaInfo['periodo'] as int,
            );
          }).toList();
        } else {
          throw Exception('Erro ao carregar grade curricular: ${gradeResponse.statusCode}');
        }
      } else {
        throw Exception('Erro ao carregar boletim: ${boletimResponse.statusCode}');
      }

      // Buscar análise
      final (concluidas, pendentes) = await _service.fetchAnalise(userId);
      _disciplinasConcluidas = concluidas;
      _disciplinasPendentes = pendentes;

      // Calcular progresso com base na carga horária
      // Buscar dados do usuário
      final userResponse = await http.get(Uri.parse('http://localhost:3000/users/$userId')).timeout(const Duration(seconds: 30));
      if (userResponse.statusCode != 200) throw Exception('Erro ao buscar usuário');
      final userData = jsonDecode(userResponse.body);
      final cursoNome = userData['curso'];

// Buscar carga horária total do curso
      final cursoResponse = await http.get(Uri.parse('http://localhost:3000/cursos?nome=$cursoNome')).timeout(const Duration(seconds: 30));
      if (cursoResponse.statusCode != 200) throw Exception('Erro ao buscar curso');
      final cursoData = jsonDecode(cursoResponse.body) as List;
      final cargaHorariaTotalCurso = cursoData.isNotEmpty ? cursoData.first['cargaHorariaTotal'] as int : 0;

// Calcular progresso com base na carga horária real do curso
      final cargaHorariaConcluida = _disciplinasConcluidas.fold(0, (sum, d) => sum + d.cargaHoraria);
      _progresso = cargaHorariaTotalCurso > 0
          ? (cargaHorariaConcluida / cargaHorariaTotalCurso)
          : 0.0;


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
      rethrow;
    }
  }
}