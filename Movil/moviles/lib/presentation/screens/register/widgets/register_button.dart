import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../routes/app_routes.dart';

class RegisterButton extends StatefulWidget {
  final TextEditingController correoController;
  final TextEditingController claveController;

  const RegisterButton({
    super.key,
    required this.correoController,
    required this.claveController,
  });

  @override
  State<RegisterButton> createState() => _RegisterButtonState();
}

class _RegisterButtonState extends State<RegisterButton> {
  bool _loading = false;

  Future<void> _registrarUsuario() async {
    final correo = widget.correoController.text.trim();
    final clave = widget.claveController.text.trim();

    if (correo.isEmpty || clave.isEmpty) {
      _mostrarDialogo("Error", "Por favor, completa todos los campos.");
      return;
    }

    setState(() => _loading = true);

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/api/v1/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'correo': correo, 'clave': clave}),
      );

      if (!mounted) return;

      if (response.statusCode == 200 || response.statusCode == 201) {
        await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            backgroundColor: const Color(0xFF18181B),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Color(0xFFC59B2D), width: 1.5),
            ),
            title: const Text(
              "¡Bienvenido!",
              style: TextStyle(
                color: Color(0xFFC59B2D),
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text(
              "Usuario registrado correctamente. ¡Gracias por unirte a FashionLab!",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.login,
                    (route) => false,
                  );
                },
                child: const Text(
                  "Ir al login",
                  style: TextStyle(
                    color: Color(0xFFC59B2D),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        );
      } else {
        final data = jsonDecode(response.body);
        _mostrarDialogo("Error", data["detail"] ?? "Error al registrar usuario.");
      }
    } catch (e) {
      _mostrarDialogo("Error", "Error de conexión al servidor.");
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
              "OK",
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
    return ElevatedButton(
      onPressed: _loading ? null : _registrarUsuario,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFC59B2D),
        minimumSize: const Size(double.infinity, 45),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: _loading
          ? const CircularProgressIndicator(color: Colors.black)
          : const Text(
              "Registrarse",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
    );
  }
}
