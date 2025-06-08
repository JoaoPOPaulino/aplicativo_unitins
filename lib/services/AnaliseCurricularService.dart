import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as developer;
import '../models/Disciplina.dart';

class AnaliseCurricularService {
  final String baseUrl = 'http://192.168.1.100:3000'; // Substitua pelo IP da sua máquina

  Future<(List<Disciplina>, List<Disciplina>)> fetchAnalise(int userId) async {
    try {
      // Buscar boletim (disciplinas concluídas)
      final boletimResponse = await http.get(Uri.parse('$baseUrl/boletim?userId=$userId')).timeout(const Duration(seconds: 30));
      developer.log('Boletim Response: ${boletimResponse.body}', name: 'AnaliseCurricularService');

      if (boletimResponse.statusCode == 200) {
        final boletimData = jsonDecode(boletimResponse.body) as List;
        final disciplinaIdsConcluidas = boletimData.map((b) => b['disciplinaId'] as int).toSet();

        // Buscar grade curricular
        final gradeResponse = await http.get(Uri.parse('$baseUrl/grade_curricular?curso=Sistemas de Informação')).timeout(const Duration(seconds: 30));
        developer.log('Grade Response: ${gradeResponse.body}', name: 'AnaliseCurricularService');

        if (gradeResponse.statusCode == 200) {
          final gradeData = jsonDecode(gradeResponse.body) as List;
          final allDisciplinas = gradeData.map((json) => Disciplina.fromJson(json)).toList();

          final disciplinasConcluidas = allDisciplinas.where((d) => disciplinaIdsConcluidas.contains(d.id)).toList();
          final disciplinasPendentes = allDisciplinas.where((d) => !disciplinaIdsConcluidas.contains(d.id)).toList();

          return (disciplinasConcluidas, disciplinasPendentes);
        } else {
          throw Exception('Erro ao carregar grade curricular: ${gradeResponse.statusCode}');
        }
      } else {
        throw Exception('Erro ao carregar boletim: ${boletimResponse.statusCode}');
      }
    } catch (e) {
      developer.log('Erro na requisição: $e', name: 'AnaliseCurricularService');
      throw Exception('Erro na requisição: $e');
    }
  }
}