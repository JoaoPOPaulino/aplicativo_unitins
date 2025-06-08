import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as developer;

import '../models/Situacao.dart';

class SituacaoService {
  final String baseUrl = 'http://localhost:3000/situacao'; // Substitua pelo IP da sua máquina

  Future<Situacao?> fetchSituacao(int userId) async {
    try {
      final uri = Uri.parse('$baseUrl?userId=$userId');
      developer.log('Requisição para: $uri', name: 'SituacaoService');
      final response = await http.get(uri).timeout(const Duration(seconds: 30));
      developer.log('Status Code: ${response.statusCode}', name: 'SituacaoService');
      developer.log('Resposta: ${response.body}', name: 'SituacaoService');

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          return Situacao.fromJson(data[0]);
        }
        developer.log('Nenhum dado encontrado para userId: $userId', name: 'SituacaoService');
        return null;
      } else {
        throw Exception('Erro ao carregar situação acadêmica: ${response.statusCode}');
      }
    } catch (e) {
      developer.log('Erro na requisição: $e', name: 'SituacaoService');
      throw Exception('Erro na requisição: $e');
    }
  }
}