import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../routes/app_routes.dart';

// Componente personalizado para ingresar el código
class VerificationCodeInput extends StatefulWidget {
  final int length;
  final Function(String) onCompleted;

  const VerificationCodeInput({
    super.key,
    this.length = 6,
    required this.onCompleted,
  });

  @override
  State<VerificationCodeInput> createState() => _VerificationCodeInputState();
}

class _VerificationCodeInputState extends State<VerificationCodeInput> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  String _currentCode = '';

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());

    for (int i = 0; i < widget.length; i++) {
      _controllers[i].addListener(() {
        if (_controllers[i].text.length == 1 && i < widget.length - 1) {
          _focusNodes[i + 1].requestFocus();
        } else if (_controllers[i].text.isEmpty && i > 0) {
          _focusNodes[i - 1].requestFocus();
        }
        _updateCode();
      });
    }
  }

  void _updateCode() {
    setState(() {
      _currentCode = _controllers.map((c) => c.text).join();
    });
    if (_currentCode.length == widget.length) {
      widget.onCompleted(_currentCode);
    }
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(widget.length, (index) {
        return SizedBox(
          width: 40,
          child: TextFormField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 20),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(1),
            ],
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFF27272A),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFC59B2D)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFC59B2D), width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        );
      }),
    );
  }
}

class ForgotPasswordCodeScreen extends StatefulWidget {
  const ForgotPasswordCodeScreen({super.key});

  @override
  State<ForgotPasswordCodeScreen> createState() => _ForgotPasswordCodeScreenState();
}

class _ForgotPasswordCodeScreenState extends State<ForgotPasswordCodeScreen> {
  String _codigoIngresado = '';
  bool _loading = false;

  Future<void> _validarCodigo(String correo) async {
    setState(() => _loading = true);

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/api/v1/auth/verify-code'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'correo': correo, 'codigo': _codigoIngresado}),
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];

        await _mostrarDialogo('Código válido', 'Ahora puedes restablecer tu contraseña.');
        Navigator.pushNamed(context, AppRoutes.resetPassword, arguments: token);
      } else {
        final data = jsonDecode(response.body);
        _mostrarDialogo('Código inválido', data['detail'] ?? 'El código ingresado es incorrecto.');
      }
    } catch (_) {
      if (!mounted) return;
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
    final correo = ModalRoute.of(context)?.settings.arguments as String? ?? '';

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF18181B),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFC59B2D), width: 2),
            ),
            width: 350,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Recuperar Contraseña",
                  style: TextStyle(color: Color(0xFFC59B2D), fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Ingrese el código de verificación que le llegó a su correo.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 32),
                VerificationCodeInput(
                  onCompleted: (code) => _codigoIngresado = code,
                ),
                const SizedBox(height: 32),
                _loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : ElevatedButton(
                        onPressed: () {
                          if (_codigoIngresado.length == 6) {
                            _validarCodigo(correo);
                          } else {
                            _mostrarDialogo('Error', 'Por favor ingresa el código completo.');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC59B2D),
                          minimumSize: const Size(double.infinity, 45),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text("Validar", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
