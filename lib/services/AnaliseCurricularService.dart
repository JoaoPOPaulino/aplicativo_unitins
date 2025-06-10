import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as developer;
import '../models/Disciplina.dart';
import '../models/User.dart';
import 'UserService.dart';

class AnaliseCurricularService {
  final String baseUrl = 'http://localhost:3000';
  final double notaMinima = 6.0;
  final double frequenciaMinima = 75.0;

  Future<(List<Disciplina>, List<Disciplina>)> fetchAnalise(int userId) async {
    try {
      final userService = UserService();
      final user = await userService.fetchUser(userId);
      final curso = user?.curso ?? 'Sistemas de Informação';
      final periodoAtual = user?.periodoAtual ?? 1;

      final situacaoResponse = await http.get(Uri.parse('$baseUrl/situacao?userId=$userId')).timeout(const Duration(seconds: 30));
      if (situacaoResponse.statusCode == 200) {
        final situacaoData = jsonDecode(situacaoResponse.body) as List;
        if (situacaoData.isNotEmpty && situacaoData.first['matriculaStatus'] != 'Ativa') {
          throw Exception('Matrícula inativa. Não é possível realizar a análise curricular.');
        }
      } else {
        throw Exception('Erro ao carregar situação: ${situacaoResponse.statusCode}');
      }

      final boletimResponse = await http.get(Uri.parse('$baseUrl/boletim?userId=$userId')).timeout(const Duration(seconds: 30));
      developer.log('Boletim Response: ${boletimResponse.body}', name: 'AnaliseCurricularService');

      if (boletimResponse.statusCode == 200) {
        final boletimData = jsonDecode(boletimResponse.body) as List;

        final disciplinaStatus = <int, Map>{};
        for (var b in boletimData) {
          final disciplinaId = b['disciplinaId'] as int;
          final semestre = b['semestreConclusao'] ?? '9999.9'; // Para ordenação, null é futuro
          if (!disciplinaStatus.containsKey(disciplinaId) || semestre.compareTo(disciplinaStatus[disciplinaId]!['semestre']) > 0) {
            // Parse frequencia, removing '%' and converting to double
            final frequenciaStr = (b['frequencia'] ?? '0%').toString().replaceAll('%', '');
            final frequencia = double.tryParse(frequenciaStr) ?? 0.0;

            disciplinaStatus[disciplinaId] = {
              'nota': b['nota'] ?? 0.0,
              'frequencia': frequencia,
              'status': b['status'],
              'semestre': semestre,
            };
          }
        }

        final disciplinaIdsConcluidas = disciplinaStatus.entries
            .where((e) => e.value['status'] == 'Aprovado' &&
            (e.value['nota'] ?? 0.0) >= notaMinima &&
            (e.value['frequencia'] as double) >= frequenciaMinima)
            .map((e) => e.key)
            .toSet();
        final disciplinaIdsReprovadas = disciplinaStatus.entries
            .where((e) => e.value['status'] == 'Reprovado' ||
            (e.value['nota'] ?? 0.0) < notaMinima ||
            (e.value['frequencia'] as double) < frequenciaMinima)
            .map((e) => e.key)
            .toSet();

        final gradeResponse = await http.get(Uri.parse('$baseUrl/grade_curricular?curso=$curso')).timeout(const Duration(seconds: 30));
        developer.log('Grade Response: ${gradeResponse.body}', name: 'AnaliseCurricularService');

        if (gradeResponse.statusCode == 200) {
          final gradeData = jsonDecode(gradeResponse.body) as List;
          final allDisciplinas = gradeData.map((json) => Disciplina.fromJson(json)).toList();

          final disciplinasConcluidas = allDisciplinas.where((d) => disciplinaIdsConcluidas.contains(d.id)).toList();
          final disciplinasPendentes = allDisciplinas
              .where((d) => !disciplinaIdsConcluidas.contains(d.id))
              .where((d) => d.periodo <= periodoAtual || d.periodo == 0) // Inclui disciplinas optativas (periodo: 0)
              .where((d) {
            final preRequisitos = d.preRequisitos ?? [];
            return preRequisitos.isEmpty || preRequisitos.every((preReqId) => disciplinaIdsConcluidas.contains(preReqId));
          })
              .toList();

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