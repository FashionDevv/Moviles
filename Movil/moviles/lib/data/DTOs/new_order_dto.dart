import 'package:moviles/data/models/order_product_model.dart';

class NewOrderDTO {
  final String fechaVenta;
  final int idCliente;
  final String tipoVenta;
  final String estado;
  final List<OrderProductModel> ventaProductos;

  NewOrderDTO({
    required this.fechaVenta,
    required this.idCliente,
    required this.tipoVenta,
    required this.estado,
    required this.ventaProductos,
  });

  Map<String, dynamic> toJson() => {
    'fecha_venta': fechaVenta,
    'id_cliente': idCliente,
    'tipo_venta': tipoVenta,
    'estado': estado,
    'venta_productos': ventaProductos.map((e) => e.toJson()).toList(),
  };
}
