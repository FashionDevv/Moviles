import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../routes/app_routes.dart';

class LoginButton extends StatefulWidget {
  final TextEditingController correoController;
  final TextEditingController claveController;

  const LoginButton({
    super.key,
    required this.correoController,
    required this.claveController,
  });

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  bool _loading = false;

  Future<void> _login() async {
    final correo = widget.correoController.text.trim();
    final clave = widget.claveController.text.trim();

    if (correo.isEmpty || clave.isEmpty) {
      _mostrarDialogo('Error', 'Todos los campos son obligatorios.');
      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/api/v1/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'correo': correo, 'clave': clave}),
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint('Login exitoso: $data');

        // Mostrar diálogo de éxito
        await _mostrarDialogo('Éxito', 'Has iniciado sesión correctamente.');

        // Redirigir a la pantalla de devoluciones
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.refund,
          (route) => false,
        );
      } else {
        _mostrarDialogo('Error', 'Credenciales inválidas.');
      }
    } catch (e) {
      _mostrarDialogo('Error', 'No se pudo conectar con el servidor.');
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Future<void> _mostrarDialogo(String titulo, String mensaje) async {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF18181B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFFC59B2D), width: 1.5),
        ),
        title: Text(
          titulo,
          style: const TextStyle(
            color: Color(0xFFC59B2D),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          mensaje,
          style: const TextStyle(color: Colors.white),
        ),
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
    return _loading
        ? const CircularProgressIndicator(color: Colors.white)
        : ElevatedButton(
            onPressed: _login,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC59B2D),
              minimumSize: const Size(double.infinity, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "Iniciar sesión",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          );
  }
}
