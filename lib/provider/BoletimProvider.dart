import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Boletim.dart';
import '../services/BoletimService.dart';


class BoletimProvider with ChangeNotifier {
  final BoletimService _boletimService = BoletimService();
  List<Boletim> _boletim = [];
  bool _isLoading = false;
  String? _error;
  int? _userId;

  List<Boletim> get boletim => _boletim;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int? get userId => _userId;

  void setUserId(int userId) {
    _userId = userId;
    notifyListeners();
  }

  Future<void> fetchBoletim() async {
    if (_userId == null) {
      _error = 'Usuário não definido';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _boletim = await _boletimService.fetchBoletim(_userId!);
    } catch (e) {
      _error = 'Falha ao carregar boletim. Tente novamente.';
      print('Erro no provider: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}