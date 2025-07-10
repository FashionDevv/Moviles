import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../DTOs/LoginDTO.dart';
import '../../DTOs/RequestResetDTO.dart';
import '../../DTOs/VerifyCodeDTO.dart';
import '../../DTOs/ChangePasswordDTO.dart';

class AuthApi {
  final String _baseUrl = 'http://127.0.0.1:5000';

  /// Login de usuario
  Future<Map<String, dynamic>> login(LoginDTO data) async {
    final url = Uri.parse('$_baseUrl/api/v1/auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data.toJson()),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Credenciales inválidas: ${response.body}');
    }
  }

  /// Solicita el código de recuperación de contraseña
  Future<void> requestReset(RequestResetDTO data) async {
    final url = Uri.parse('$_baseUrl/api/v1/auth/request-reset');
    final response = await http.post(
      url,
      body: jsonEncode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al solicitar código: ${response.body}');
    }
  }

  /// Verifica el código enviado por correo
  Future<String> verifyCode(VerifyCodeDTO data) async {
    final url = Uri.parse('$_baseUrl/api/v1/auth/verify-code');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data.toJson()),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['token']; // JWT
    } else {
      throw Exception('Código inválido: ${response.body}');
    }
  }

  /// Cambia la contraseña del usuario
  Future<void> changePassword(ChangePasswordDTO data) async {
    final url = Uri.parse('$_baseUrl/api/v1/auth/change-password');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al cambiar contraseña: ${response.body}');
    }
  }
}
