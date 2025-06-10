import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as developer;
import '../models/Disciplina.dart';
import '../models/User.dart';
import 'UserService.dart';

class AnaliseCurricularService {
  final String baseUrl = 'http://localhost:3000';
  final double notaMinima = 7.0; // Ajuste conforme a regra do curso

  Future<(List<Disciplina>, List<Disciplina>)> fetchAnalise(int userId) async {
    try {
      // Buscar curso e período atual do usuário
      final userService = UserService();
      final user = await userService.fetchUser(userId);
      final curso = user?.curso ?? 'Sistemas de Informação';
      final periodoAtual = user?.periodoAtual ?? 1;

      // Buscar boletim
      final boletimResponse = await http.get(Uri.parse('$baseUrl/boletim?userId=$userId')).timeout(const Duration(seconds: 30));
      developer.log('Boletim Response: ${boletimResponse.body}', name: 'AnaliseCurricularService');

      if (boletimResponse.statusCode == 200) {
        final boletimData = jsonDecode(boletimResponse.body) as List;
        final disciplinaIdsConcluidas = boletimData
            .where((b) => b['status'] == 'Aprovado' && (b['nota'] ?? 0) >= notaMinima)
            .map((b) => b['disciplinaId'] as int)
            .toSet();
        final disciplinaIdsReprovadas = boletimData
            .where((b) => b['status'] == 'Reprovado' || (b['nota'] ?? 0) < notaMinima)
            .map((b) => b['disciplinaId'] as int)
            .toSet();

        // Buscar grade curricular com base no curso do usuário
        final gradeResponse = await http.get(Uri.parse('$baseUrl/grade_curricular?curso=$curso')).timeout(const Duration(seconds: 30));
        developer.log('Grade Response: ${gradeResponse.body}', name: 'AnaliseCurricularService');

        if (gradeResponse.statusCode == 200) {
          final gradeData = jsonDecode(gradeResponse.body) as List;
          final allDisciplinas = gradeData.map((json) => Disciplina.fromJson(json)).toList();

          final disciplinasConcluidas = allDisciplinas.where((d) => disciplinaIdsConcluidas.contains(d.id)).toList();
          final disciplinasPendentes = allDisciplinas
              .where((d) => !disciplinaIdsConcluidas.contains(d.id))
              .where((d) => d.periodo <= periodoAtual) // Apenas disciplinas do período atual ou anteriores
              .where((d) {
            final preRequisitos = d.preRequisitos ?? [];
            return preRequisitos.isEmpty || preRequisitos.every((preReqId) => disciplinaIdsConcluidas.contains(preReqId));
          })
              .toList();

          // Adicionar disciplinas reprovadas às pendentes, evitando duplicatas
          final disciplinasReprovadas = allDisciplinas
              .where((d) => disciplinaIdsReprovadas.contains(d.id))
              .where((d) => !disciplinasPendentes.any((p) => p.id == d.id)) // Evita duplicatas
              .toList();
          disciplinasPendentes.addAll(disciplinasReprovadas);

          return (disciplinasConcluidas, disciplinasPendentes);
        } else {
          throw Exception('Erro ao carregar grade curricular: ${gradeResponse.statusCode}');
        }
      } else {
        throw Exception('Erro ao carregar boletim: ${boletimResponse.statusCode}');
      }
    } catch (e) {
      developer.log('Erro na requisição: $e', name: 'AnaliseCurricularService');
      rethrow;
    }
  }
}