import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/User.dart';

class UserService {
  final String baseUrl = 'http://localhost:3000/users';

  Future<User?> fetchUser(int userId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl?id=$userId')).timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          return User.fromJson(data[0]);
        }
        return null;
      } else {
        throw Exception('Erro ao carregar usuário: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro na requisição: $e');
    }
  }
}