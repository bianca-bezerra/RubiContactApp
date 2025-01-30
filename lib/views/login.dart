import 'package:flutter/material.dart';
import 'package:google_maps/components/button.dart';

class LoginView extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;

  const LoginView({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: screenWidth,
            // decoration: BoxDecoration(
            //   color: AppColors.gray,
            //   border: Border(
            //     top: BorderSide(
            //         color: AppColors.backgroundSecondary, width: 0.5),
            //     bottom: BorderSide(
            //         color: AppColors.backgroundSecondary, width: 0.5),
            //   ),
            // ),
            padding:
                const EdgeInsets.symmetric(horizontal: 0.0, vertical: 56.0),
            constraints: BoxConstraints(
              minHeight: screenHeight * 0.4,
              maxHeight: screenHeight * 0.6,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 48.0),
                _buildForm(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterPrompt(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Não está cadastrado ainda? ',
          // style: AppTextStyles.titleExtraSmall,
        ),
        InkWell(
          // onTap: () => context.go(Routes.register),
          child: Text(
            'Registre-se',
            // style: GoogleFonts.inter(
            //   fontSize: 16,
            //   fontWeight: FontWeight.w600,
            //   color: AppColors.green,
            //   letterSpacing: -1.0,
            // ),
          ),
        ),
      ],
    );
  }

  Widget _buildForm(BuildContext context) {
    return Expanded(
      child: Center(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildInputField(
                  controller: emailController,
                  labelText: 'E-mail',
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira seu e-mail';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                        .hasMatch(value)) {
                      return 'Por favor, insira um e-mail válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                buildInputField(
                  controller: passwordController,
                  labelText: 'Senha',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira sua senha';
                    } else if (value.length < 6) {
                      return 'A senha deve ter pelo menos 6 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24.0),
                const Spacer(),
                _buildLoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputField({
    required TextEditingController controller,
    required String labelText,
    required bool obscureText,
    bool isCPFField = false,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
            width: 1.5,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
            width: 1,
          ),
        ),
      ),
      obscureText: obscureText,
      validator: validator,
    );
  }

  Widget _buildLoginButton() {
    return Button(
      title: 'Entrar',
      onPress: onLogin,
      backgroundColor: Colors.black,
    );
  }
}
