import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../routes/app_routes.dart';

class ForgotButton extends StatefulWidget {
  final TextEditingController correoController;

  const ForgotButton({super.key, required this.correoController});

  @override
  State<ForgotButton> createState() => _ForgotButtonState();
}

class _ForgotButtonState extends State<ForgotButton> {
  bool _loading = false;

  Future<void> _requestResetCode() async {
    final correo = widget.correoController.text.trim();

    if (correo.isEmpty) {
      _showDialog('Error', 'Por favor ingresa tu correo.');
      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/api/v1/auth/request-reset'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'correo': correo}),
      );


      if (!mounted) return;

      if (response.statusCode == 200) {
        await _showDialog('Código enviado', 'El código fue enviado a tu correo.');
        Navigator.pushNamed(context, AppRoutes.forgotPasswordCode, arguments: correo);
      } else {
        final data = json.decode(response.body);
        _showDialog('Error', data['detail'] ?? 'No se pudo enviar el código.');
      }
    } catch (e) {
      if (!mounted) return;
      _showDialog('Error', 'Error de conexión al servidor.');
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Future<void> _showDialog(String title, String message) async {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: const Color(0xFF18181B),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFC59B2D), width: 1.5),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFFC59B2D),
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        message,
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
    return ElevatedButton(
      onPressed: _loading ? null : _requestResetCode,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFC59B2D),
        minimumSize: const Size(double.infinity, 36),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: _loading
          ? const CircularProgressIndicator(color: Colors.black)
          : const Text(
              "Enviar",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
    );
  }
}
