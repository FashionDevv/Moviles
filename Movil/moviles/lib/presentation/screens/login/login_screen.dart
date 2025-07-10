// LoginScreen.dart
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'widgets/login_logo.dart';
import 'widgets/login_input.dart';
import 'widgets/login_button.dart';
import '../../routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _claveController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: const Color(0xFF18181B),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFC59B2D), width: 2),
          ),
          width: 350,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              const Text(
                "Fashion Lab",
                style: TextStyle(
                  color: Color(0xFFC59B2D),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Iniciar Sesión",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 16),
              const LoginLogo(),
              const SizedBox(height: 24),
              LoginInput(
                label: "Usuario",
                hintText: "Ingrese su usuario.",
                controller: _correoController,
              ),
              const SizedBox(height: 16),
              LoginInput(
                label: "Clave",
                hintText: "Ingrese su clave.",
                obscure: true,
                controller: _claveController,
              ),
              const SizedBox(height: 24),
              LoginButton(
                correoController: _correoController,
                claveController: _claveController,
              ),
              const SizedBox(height: 24),
              RichText(
                text: TextSpan(
                  text: "¿No tienes cuenta? ",
                  style: const TextStyle(color: Colors.white),
                  children: [
                    TextSpan(
                      text: "Regístrate aquí",
                      style: const TextStyle(
                        color: Color(0xFFC59B2D),
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, AppRoutes.register);
                        },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text.rich(
                TextSpan(
                  text: "¿No puedes entrar? ",
                  style: const TextStyle(color: Colors.white),
                  children: [
                    TextSpan(
                      text: "Recuperar contraseña",
                      style: const TextStyle(
                        color: Color(0xFFC59B2D),
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, AppRoutes.forgotPassword);
                        },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
