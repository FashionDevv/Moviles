class OrderProductModel {
  final int codigoPTC;
  final double precioUnitario;
  final int cantidad;
  double? subtotal;
  int? codigoVenta;

  OrderProductModel({
    required this.codigoPTC,
    required this.precioUnitario,
    required this.cantidad,
    this.subtotal,
    this.codigoVenta,
  });

  Map<String, dynamic> toJson() {
    final data = {
      'codigo_ptc': codigoPTC,
      'precio_unitario': precioUnitario,
      'cantidad': cantidad,
      'subtotal': subtotal ?? (precioUnitario * cantidad),
    };

    return data;
  }
}
