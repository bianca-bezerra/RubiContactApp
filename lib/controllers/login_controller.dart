import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps/routing/routes.dart';

import 'package:google_maps/views/login.dart';

class LoginController extends StatefulWidget {
  const LoginController({super.key});

  @override
  State<LoginController> createState() => _LoginControllerState();
}

class _LoginControllerState extends State<LoginController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;

      if (email == "bia@gmail.com" && password == "123456") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login realizado com sucesso!!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );

        if (!mounted) {
          return;
        }

        Future.delayed(const Duration(seconds: 2))
            .then((value) => GoRouter.of(context).go(Routes.home));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('E-mail ou senha inválidos!!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoginView(
      formKey: _formKey,
      emailController: _emailController,
      passwordController: _passwordController,
      onLogin: _login,
    );
  }
}
