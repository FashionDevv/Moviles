class OrderModel {
  final int codigoVenta;
  final int idCliente;
  final String fechaVenta;
  final String tipoVenta;
  final String estado;
  final String total;
  final List<VentaProducto> ventaProductos;

  OrderModel({
    required this.codigoVenta,
    required this.idCliente,
    required this.fechaVenta,
    required this.tipoVenta,
    required this.estado,
    required this.total,
    required this.ventaProductos,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      codigoVenta: json['codigo_venta'] ?? 0,
      idCliente: json['id_cliente'] ?? 0,
      fechaVenta: json['fecha_venta'] ?? '',
      tipoVenta: json['tipo_venta'] ?? '',
      estado: json['estado'] ?? '',
      total: json['total'] ?? '0.00',
      ventaProductos:
          (json['venta_productos'] as List<dynamic>? ?? [])
              .map((e) => VentaProducto.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codigo_venta': codigoVenta,
      'id_cliente': idCliente,
      'fecha_venta': fechaVenta,
      'tipo_venta': tipoVenta,
      'estado': estado,
      'total': total,
      'venta_productos': ventaProductos.map((e) => e.toJson()).toList(),
    };
  }
}

class VentaProducto {
  final int codigoVentaProductos;
  final int codigoVenta;
  final int codigoPtc;
  final String precioUnitario;
  final int cantidad;
  final String subtotal;

  VentaProducto({
    required this.codigoVentaProductos,
    required this.codigoVenta,
    required this.codigoPtc,
    required this.precioUnitario,
    required this.cantidad,
    required this.subtotal,
  });

  factory VentaProducto.fromJson(Map<String, dynamic> json) {
    return VentaProducto(
      codigoVentaProductos: json['codigo_venta_productos'] ?? 0,
      codigoVenta: json['codigo_venta'] ?? 0,
      codigoPtc: json['codigo_ptc'] ?? 0,
      precioUnitario: json['precio_unitario'] ?? '0.00',
      cantidad: json['cantidad'] ?? 0,
      subtotal: json['subtotal'] ?? '0.00',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codigo_venta_productos': codigoVentaProductos,
      'codigo_venta': codigoVenta,
      'codigo_ptc': codigoPtc,
      'precio_unitario': precioUnitario,
      'cantidad': cantidad,
      'subtotal': subtotal,
    };
  }
}
