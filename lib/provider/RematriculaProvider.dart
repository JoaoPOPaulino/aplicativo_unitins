import 'package:flutter/material.dart';
import '../models/Disciplina.dart';
import '../services/UserService.dart';

class RematriculaProvider with ChangeNotifier {
  final UserService _userService = UserService();
  int? _userId;
  List<Disciplina> _disciplinas = [];
  final Map<int, String> _userCache = {};
  int? _periodoAtual;
  String? _curso;

  void setUserId(int userId) {
    _userId = userId;
    _loadUserData();
    notifyListeners();
  }

  void setDisciplinas(List<Disciplina> disciplinas) {
    _disciplinas = disciplinas;
    notifyListeners();
  }

  List<Disciplina> getDisciplinas() => _disciplinas;
  String? getUserName(int userId) => _userCache[userId];
  int? get periodoAtual => _periodoAtual;
  String? get curso => _curso;

  Future<void> _loadUserData() async {
    if (_userId != null) {
      final user = await _userService.fetchUser(_userId!);
      if (user != null) {
        _userCache[_userId!] = user.nome;
        _periodoAtual = user.periodoAtual;
        _curso = user.curso;
        notifyListeners();
      }
    }
  }

  bool isMatriculado(int periodo) {
    return _disciplinas.isNotEmpty;
  }
}