import 'package:aplicativo_unitins/provider/BoletimProvider.dart';
import 'package:aplicativo_unitins/screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/RematriculaProvider.dart';
import '../provider/AnaliseCurricularProvider.dart'; // Importe o AnaliseCurricularProvider

void main() {
  runApp(const AppAcademico());
}

class AppAcademico extends StatelessWidget {
  const AppAcademico({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BoletimProvider()),
        ChangeNotifierProvider(create: (_) => RematriculaProvider()),
        ChangeNotifierProvider(create: (_) => AnaliseCurricularProvider()), // Adicione o AnaliseCurricularProvider
      ],
      child: MaterialApp(
        title: 'App Acadêmico',
        home: const LoginScreen(),
      ),
    );
  }
}