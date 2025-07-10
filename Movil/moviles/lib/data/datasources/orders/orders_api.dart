import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moviles/data/DTOs/new_order_dto.dart';
import '../../models/order_model.dart';

class OrdersApi {
  final String _baseUrl = 'http://127.0.0.1:5000';

  Future<List<OrderModel>> getAllOrders() async {
    final url = Uri.parse('$_baseUrl/api/v1/sales/GetAllOrders');
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => OrderModel.fromJson(e)).toList();
    } else {
      throw Exception('Error al obtener pedidos: ${response.body}');
    }
  }

  Future<void> addOrder(NewOrderDTO newOrder) async {
    final url = Uri.parse('$_baseUrl/api/v1/sales/AddSale');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(newOrder.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception(
        'Error al agregar el pedido.\nCódigo: ${response.statusCode}\nCuerpo: ${response.body}',
      );
    }
  }

  Future<void> changeOrderState({
    required int saleCode,
    required String estado,
  }) async {
    final url = Uri.parse(
      "$_baseUrl/api/v1/sales/ChangeState/$saleCode?state=$estado",
    );
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Error al cambiar el estado: ${response.body}');
    }
  }
}
