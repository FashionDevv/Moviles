import 'package:moviles/presentation/screens/refund/models/RefundProductModel.dart';

class NewRefundsDTO {
  final int codigoVenta;
  final String? fechaDevolucion;
  final double? total;
  final String estado;
  final List<RefundProductModel> devolucionProductos;

  NewRefundsDTO({
    required this.codigoVenta,
    this.fechaDevolucion,
    this.total, 
    required this.estado,
    required this.devolucionProductos,
  });

  Map<String, dynamic> toJson() => {
        'codigo_venta': codigoVenta,
        'fecha_devolucion': fechaDevolucion,
        'total': total,
        'estado': estado,
        'devolucion_productos':
            devolucionProductos.map((e) => e.toJson()).toList(),
      };
}
