import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../routes/app_routes.dart';
import '../register/widgets/register_input.dart';
import '../register/widgets/register_dropdown.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _correoController = TextEditingController();
  final _claveController = TextEditingController();
  final _confirmarClaveController = TextEditingController();
  final _documentoController = TextEditingController();
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _telefonoController = TextEditingController();

  String? selectedTipoDocumento;
  bool _loading = false;

  Future<void> _registrarUsuario() async {
    final correo = _correoController.text.trim();
    final clave = _claveController.text.trim();
    final confirmarClave = _confirmarClaveController.text.trim();

    if (correo.isEmpty || clave.isEmpty || confirmarClave.isEmpty) {
      _mostrarDialogo("Error", "Correo y claves son obligatorios.");
      return;
    }

    if (clave != confirmarClave) {
      _mostrarDialogo("Error", "Las contraseñas no coinciden.");
      return;
    }

    setState(() => _loading = true);

    try {
      final response = await http.post(
        Uri.parse("http://127.0.0.1:5000/api/v1/users/AddUser"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "correo": correo,
          "clave": clave,
          "estado": true,
          "id_rol": 2,
        }),
      );

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      if (!mounted) return;

      if (response.statusCode >= 200 && response.statusCode < 300) {
        await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            backgroundColor: const Color(0xFF18181B),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Color(0xFFC59B2D), width: 1.5),
            ),
            title: const Text(
              "Éxito",
              style: TextStyle(
                color: Color(0xFFC59B2D),
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text(
              "Usuario registrado correctamente.",
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
                  "OK",
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
        _mostrarDialogo("Error", data["detail"] ?? "No se pudo registrar.");
      }
    } catch (_) {
      _mostrarDialogo("Error", "No se pudo conectar con el servidor.");
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
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
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
                Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.login),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFFC59B2D),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.arrow_back,
                            size: 18, color: Color(0xFFC59B2D)),
                        SizedBox(width: 4),
                        Text(
                          "Volver al login",
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFFC59B2D),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
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
                  "Registrarse",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(height: 24),

                RegisterDropdown(
                  label: "Tipo documento",
                  selectedValue: selectedTipoDocumento,
                  onChanged: (value) {
                    setState(() {
                      selectedTipoDocumento = value;
                    });
                  },
                ),
                const SizedBox(height: 10),

                RegisterInput(
                    label: "Documento",
                    hintText: "Ingrese su documento",
                    controller: _documentoController),
                RegisterInput(
                    label: "Nombre",
                    hintText: "Ingrese su nombre",
                    controller: _nombreController),
                RegisterInput(
                    label: "Apellido",
                    hintText: "Ingrese su apellido",
                    controller: _apellidoController),
                RegisterInput(
                    label: "Teléfono",
                    hintText: "Ingrese su teléfono",
                    controller: _telefonoController),
                RegisterInput(
                    label: "Correo",
                    hintText: "Ingrese su correo",
                    controller: _correoController),
                RegisterInput(
                    label: "Clave",
                    hintText: "Ingrese su clave",
                    obscure: true,
                    controller: _claveController),
                RegisterInput(
                    label: "Confirmar clave",
                    hintText: "Ingrese su clave nuevamente",
                    obscure: true,
                    controller: _confirmarClaveController),
                const SizedBox(height: 24),

                _loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : ElevatedButton(
                        onPressed: _registrarUsuario,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC59B2D),
                          minimumSize: const Size(double.infinity, 45),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text(
                          "Registrarse",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
