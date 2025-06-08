import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/Boletim.dart';


class BoletimService {
  final String baseUrl = 'http://localhost:3000/boletim';

  Future<List<Boletim>> fetchBoletim(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl?userId=$userId'),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        // Adicione este print para debug
        print('Resposta da API: ${response.body}');

        final dynamic responseData = jsonDecode(response.body);

        // Verifica se é uma lista direta ou um objeto com propriedade 'boletim'
        List<dynamic> boletimData = [];
        if (responseData is List) {
          boletimData = responseData;
        } else if (responseData is Map && responseData.containsKey('boletim')) {
          boletimData = responseData['boletim'];
        } else {
          throw Exception('Formato de resposta inválido');
        }

        return boletimData.map((json) => Boletim.fromJson(json)).toList();
      } else {
        throw Exception('Erro ao carregar boletim: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro na requisição: $e');
      throw Exception('Erro na requisição: $e');
    }
  }
}