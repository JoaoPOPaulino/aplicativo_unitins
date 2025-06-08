import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/Disciplina.dart';


class GradeCurricularService {
  final String baseUrl = 'http://localhost:3000/grade_curricular';

  Future<List<Disciplina>> fetchGradeCurricular(String curso) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl?curso=$curso')).timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Disciplina.fromJson(json)).toList();
      } else {
        throw Exception('Erro ao carregar grade curricular: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro na requisição: $e');
    }
  }
}