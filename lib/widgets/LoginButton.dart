import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const LoginButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.login),
        label: const Text('Entrar'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade700,
        ),
      ),
    );
  }
}