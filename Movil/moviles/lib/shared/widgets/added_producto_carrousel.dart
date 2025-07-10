import 'package:flutter/material.dart';
import '../../data/models/order_product_model.dart';

class AddedProductCarouselReadOnly extends StatelessWidget {
  final List<OrderProductModel> productos;

  const AddedProductCarouselReadOnly({super.key, required this.productos});

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          productos.map((producto) {
            return Card(
              color: Colors.white10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                title: Text(
                  'Producto: ${producto.codigoPTC}',
                  style: const TextStyle(color: Colors.white),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cantidad: ${producto.cantidad}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    Text(
                      'Precio Unitario: \$${producto.precioUnitario}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    Text(
                      'Subtotal: \$${producto.subtotal ?? (producto.precioUnitario * producto.cantidad)}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
    );
  }
}
