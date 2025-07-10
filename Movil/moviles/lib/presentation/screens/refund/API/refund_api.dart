import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moviles/presentation/screens/refund/DTOs/NewRefundDTO.dart';
import 'package:moviles/presentation/screens/refund/models/RefundModel.dart';


class RefundsApi {
  final String _baseUrl = 'http://127.0.0.1:5000'; // Cambia el puerto si es necesario

  Future<List<RefundModel>> getAllRefunds() async {
    final url = Uri.parse('$_baseUrl/api/v1/refunds/GetAllRefunds');
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => RefundModel.fromJson(e)).toList();
    } else {
      throw Exception('Error al obtener devoluciones: ${response.body}');
    }
  }

  Future<RefundModel> getRefundById(int codigoDevolucion) async {
    final url = Uri.parse('$_baseUrl/GetRefundById/$codigoDevolucion');
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return RefundModel.fromJson(data);
    } else {
      throw Exception(
        'Error al obtener la devolución $codigoDevolucion: ${response.body}',
      );
    }
  }

  Future<void> addRefund(NewRefundsDTO newRefund) async {
    final url = Uri.parse('$_baseUrl/api/v1/refunds/AddRefund');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(newRefund.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Error al agregar la devolución.\nCódigo: ${response.statusCode}\nCuerpo: ${response.body}',
      );
    }
  }
}
