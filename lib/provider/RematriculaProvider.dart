import 'package:flutter/material.dart';
import '../models/Disciplina.dart';
import '../models/User.dart';
import '../services/UserService.dart';

class RematriculaProvider with ChangeNotifier {
  final UserService _userService = UserService();
  int? _userId;
  List<Disciplina> _disciplinas = [];
  final Map<int, String> _userCache = {}; // Cache de nomes de usuários

  void setUserId(int userId) {
    _userId = userId;
    _loadUserName();
    notifyListeners();
  }

  void setDisciplinas(List<Disciplina> disciplinas) {
    _disciplinas = disciplinas;
    notifyListeners();
  }

  List<Disciplina> getDisciplinas() => _disciplinas;

  String? getUserName(int userId) => _userCache[userId];

  Future<void> _loadUserName() async {
    if (_userId != null && !_userCache.containsKey(_userId)) {
      final user = await _userService.fetchUser(_userId!);
      if (user != null) {
        _userCache[_userId!] = user.nome;
        notifyListeners();
      }
    }
  }

  bool isMatriculado(int periodo) {
    // Simulação: Assume que o usuário já está matriculado se houver disciplinas
    return _disciplinas.isNotEmpty;
    // Para uma lógica real, integre com o servidor (ex.: endpoint /matricula)
  }
}