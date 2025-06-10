import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/Boletim.dart';

class BoletimService {
  final String baseUrl = 'http://localhost:3000';

  Future<List<Boletim>> fetchBoletim(int userId) async {
    try {
      // Buscar dados do boletim
      final boletimResponse = await http.get(
        Uri.parse('$baseUrl/boletim?userId=$userId'),
      ).timeout(const Duration(seconds: 30));

      if (boletimResponse.statusCode == 200) {
        print('Resposta da API (boletim): ${boletimResponse.body}');
        final boletimData = jsonDecode(boletimResponse.body) as List<dynamic>;

        // Buscar grade curricular para mapear disciplinaId para nome e período
        final gradeResponse = await http.get(
          Uri.parse('$baseUrl/grade_curricular'),
        ).timeout(const Duration(seconds: 30));

        if (gradeResponse.statusCode == 200) {
          print('Resposta da API (grade_curricular): ${gradeResponse.body}');
          final gradeData = jsonDecode(gradeResponse.body) as List<dynamic>;

          // Criar mapa de disciplinaId para nome e período da disciplina
          final disciplinaMap = {
            for (var item in gradeData)
              int.parse(item['id'].toString()): {
                'nome': item['disciplina'].toString(),
                'periodo': int.parse(item['periodo'].toString()),
              }
          };

          // Mapear boletim com nomes e períodos das disciplinas
          return boletimData.map((json) {
            final disciplinaId = int.parse(json['disciplinaId']?.toString() ?? '0');
            final disciplinaInfo = disciplinaMap[disciplinaId] ?? {
              'nome': 'Disciplina não encontrada',
              'periodo': 0,
            };
            return Boletim.fromJson(json, disciplinaInfo['nome'] as String, disciplinaInfo['periodo'] as int);
          }).toList();
        } else {
          throw Exception('Erro ao carregar grade curricular: ${gradeResponse.statusCode}');
        }
      } else {
        throw Exception('Erro ao carregar boletim: ${boletimResponse.statusCode}');
      }
    } catch (e) {
      print('Erro na requisição: $e');
      throw Exception('Erro na requisição: $e');
    }
  }
}