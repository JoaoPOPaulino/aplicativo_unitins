import 'package:flutter/material.dart';
import '../services/AuthService.dart';

import '../widgets/EmailField.dart';
import '../widgets/PasswordField.dart';
import '../widgets/LoginButton.dart';
import 'DashboardScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  void _login() async {
    if (_emailController.text.trim().isEmpty || _passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final user = await _authService.login(_emailController.text.trim(), _passwordController.text.trim());
      setState(() {
        _isLoading = false;
      });

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardScreen(userId: user.id),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('E-mail ou senha inválidos')),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro na autenticação: $e')),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ícone ou logo
              Icon(Icons.school, size: 80, color: Colors.blue.shade700),
              const SizedBox(height: 24),

              // Título
              const Text(
                'Bem-vindo ao Portal Acadêmico',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),

              // Campo de email
              EmailField(controller: _emailController),
              const SizedBox(height: 16),

              // Campo de senha
              PasswordField(controller: _passwordController),
              const SizedBox(height: 24),

              // Botão de login
              LoginButton(
                isLoading: _isLoading,
                onPressed: _login,
              ),
            ],
          ),
        ),
      ),
    );
  }
}