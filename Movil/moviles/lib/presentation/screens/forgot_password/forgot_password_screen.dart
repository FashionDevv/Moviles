// ForgotPasswordScreen.dart
import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import '../forgot_password/widgets/forgot_password_input.dart';
import '../forgot_password/widgets/forgot_password_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _correoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 237, 247),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 350,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF18181B),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFC59B2D), width: 2),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.login);
                    },
                    icon: const Icon(Icons.arrow_back, color: Color(0xFFC59B2D)),
                    label: const Text(
                      "Volver al login",
                      style: TextStyle(
                        color: Color(0xFFC59B2D),
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFFC59B2D),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Recuperar Contraseña",
                  style: TextStyle(
                    color: Color(0xFFC59B2D),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Ingrese su email para\nrecuperar su contraseña.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),
                ForgotInput(
                  label: "Correo",
                  hintText: "Ingrese su correo",
                  controller: _correoController,
                ),
                const SizedBox(height: 24),
                ForgotButton(correoController: _correoController),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
