class RefundProductModel {
  final int? codigoDevolucionProductos; // <-- nullable
  final int? codigoDevolucion;          // <-- nullable
  final int codigoVentaProductos;
  final double precioUnitario;
  final int cantidad;
  final double? subtotal;

  RefundProductModel({
    this.codigoDevolucionProductos, // <-- ya no required
    this.codigoDevolucion,          // <-- ya no required
    required this.codigoVentaProductos,
    required this.precioUnitario,
    required this.cantidad,
    this.subtotal,
  });

  Map<String, dynamic> toJson() {
    return {
      'codigo_devolucion_productos': codigoDevolucionProductos,
      'codigo_devolucion': codigoDevolucion,
      'codigo_venta_productos': codigoVentaProductos,
      'precio_unitario': precioUnitario,
      'cantidad': cantidad,
      'subtotal': subtotal ?? (precioUnitario * cantidad),
    };
  }
}
