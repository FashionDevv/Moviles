class RefundModel {
  final int codigoDevolucion;
  final int codigoVenta;
  final String fechaDevolucion;
  final String total; // Cambiado a String
  final String estado;
  final List<RefundProduct> devolucionProductos;

  RefundModel({
    required this.codigoDevolucion,
    required this.codigoVenta,
    required this.fechaDevolucion,
    required this.total,
    required this.estado,
    required this.devolucionProductos,
  });

  factory RefundModel.fromJson(Map<String, dynamic> json) {
    return RefundModel(
      codigoDevolucion: json['codigo_devolucion'] ?? 0,
      codigoVenta: json['codigo_venta'] ?? 0,
      fechaDevolucion: json['fecha_devolucion'] ?? '',
      total: json['total']?.toString() ?? '0.00', // Forzamos a String
      estado: json['estado'] ?? '',
      devolucionProductos: (json['devolucion_productos'] as List<dynamic>? ?? [])
          .map((e) => RefundProduct.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codigo_devolucion': codigoDevolucion,
      'codigo_venta': codigoVenta,
      'fecha_devolucion': fechaDevolucion,
      'total': total,
      'estado': estado,
      'devolucion_productos':
          devolucionProductos.map((e) => e.toJson()).toList(),
    };
  }
}

class RefundProduct {
  final int codigoDevolucionProductos;
  final int codigoDevolucion;
  final int codigoVentaProductos;
  final String precioUnitario; // Cambiado a String
  final int cantidad;
  final String subtotal; // Cambiado a String

  RefundProduct({
    required this.codigoDevolucionProductos,
    required this.codigoDevolucion,
    required this.codigoVentaProductos,
    required this.precioUnitario,
    required this.cantidad,
    required this.subtotal,
  });

  factory RefundProduct.fromJson(Map<String, dynamic> json) {
    return RefundProduct(
      codigoDevolucionProductos: json['codigo_devolucion_productos'] ?? 0,
      codigoDevolucion: json['codigo_devolucion'] ?? 0,
      codigoVentaProductos: json['codigo_venta_productos'] ?? 0,
      precioUnitario: json['precio_unitario']?.toString() ?? '0.00',
      cantidad: json['cantidad'] ?? 0,
      subtotal: json['subtotal']?.toString() ?? '0.00',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codigo_devolucion_productos': codigoDevolucionProductos,
      'codigo_devolucion': codigoDevolucion,
      'codigo_venta_productos': codigoVentaProductos,
      'precio_unitario': precioUnitario,
      'cantidad': cantidad,
      'subtotal': subtotal,
    };
  }
}
