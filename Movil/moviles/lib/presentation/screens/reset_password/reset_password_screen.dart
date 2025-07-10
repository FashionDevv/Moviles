import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../routes/app_routes.dart';
import '../login/widgets/login_input.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _claveController = TextEditingController();
  final TextEditingController _confirmarClaveController = TextEditingController();
  bool _loading = false;

  Future<void> _resetPassword(String token) async {
    final clave = _claveController.text.trim();
    final confirmarClave = _confirmarClaveController.text.trim();

    if (clave.isEmpty || confirmarClave.isEmpty) {
      _mostrarDialogo('Error', 'Todos los campos son obligatorios.');
      return;
    }

    if (clave != confirmarClave) {
      _mostrarDialogo('Error', 'Las contraseñas no coinciden.');
      return;
    }

    setState(() => _loading = true);

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/api/v1/auth/change-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'token': token, 'nueva_clave': clave}),
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        await _mostrarDialogo('Éxito', 'Tu contraseña ha sido restablecida.');
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
      } else {
        final data = jsonDecode(response.body);
        _mostrarDialogo('Error', data['detail'] ?? 'Error al restablecer la contraseña.');
      }
    } catch (_) {
      _mostrarDialogo('Error', 'No se pudo conectar con el servidor.');
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  Future<void> _mostrarDialogo(String titulo, String mensaje) async {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: const Color(0xFF18181B),
      title: Text(
        titulo,
        style: const TextStyle(
          color: Color(0xFFC59B2D),
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        mensaje,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'OK',
            style: TextStyle(
              color: Color(0xFFC59B2D),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    final token = ModalRoute.of(context)?.settings.arguments as String? ?? '';

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
                "Restablecer Contraseña",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 24),
              LoginInput(
                label: "Nueva clave",
                hintText: "Ingrese su nueva clave.",
                obscure: true,
                controller: _claveController,
              ),
              const SizedBox(height: 16),
              LoginInput(
                label: "Confirmar clave",
                hintText: "Repita la nueva clave.",
                obscure: true,
                controller: _confirmarClaveController,
              ),
              const SizedBox(height: 32),
              _loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : ElevatedButton(
                      onPressed: () => _resetPassword(token),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC59B2D),
                        minimumSize: const Size(double.infinity, 45),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text(
                        "Restablecer",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
