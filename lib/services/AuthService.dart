import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/User.dart';

class AuthService {
  final String baseUrl = 'http://localhost:3000/users';

  Future<User?> login(String email, String senha) async {
    try {
      if (email.isEmpty || senha.isEmpty) {
        throw Exception('E-mail e senha são obrigatórios');
      }

      final response = await http.get(
        Uri.parse('$baseUrl?email=$email'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (data.isEmpty) {
          throw Exception('Usuário não encontrado');
        }

        final user = User.fromJson(data[0]);
        if (user.senha != senha) {
          throw Exception('Senha incorreta');
        }
        return user;
      } else {
        throw Exception('Erro no servidor: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro no login: $e');
      rethrow;
    }
  }
}