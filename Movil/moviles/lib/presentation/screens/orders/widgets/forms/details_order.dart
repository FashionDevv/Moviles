import 'package:flutter/material.dart';
import '../../../../../data/models/order_model.dart';
import '../../../../../data/models/order_product_model.dart';
import '../../../../../data/datasources/orders/products_data.dart';
import '../../../../../data/models/product.dart';
import '../../../../../shared/layouts/BaseLayout.dart';

class DetailsOrder extends StatelessWidget {
  final OrderModel order;

  const DetailsOrder({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final productosConvertidos =
        order.ventaProductos.map((e) {
          return OrderProductModel(
            codigoPTC: e.codigoPtc,
            precioUnitario: double.tryParse(e.precioUnitario) ?? 0.0,
            cantidad: e.cantidad,
            subtotal: double.tryParse(e.subtotal) ?? 0.0,
            codigoVenta: e.codigoVenta,
          );
        }).toList();

    return BaseLayout(
      title: 'Detalles del Pedido',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfo('Cliente', 'Cliente ${order.idCliente}'),
            _buildInfo('Fecha', order.fechaVenta.split("T").first),
            _buildInfo('Tipo de Venta', order.tipoVenta),
            _buildInfo('Estado', order.estado),
            _buildInfo('Total', '\$${order.total}'),
            const SizedBox(height: 20),
            Text(
              'Productos del pedido',
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(color: Colors.amber),
            ),
            const SizedBox(height: 10),
            Column(
              children:
                  productosConvertidos.map((item) {
                    final product = sampleProducts.firstWhere(
                      (p) => p.id == item.codigoPTC,
                      orElse:
                          () => Product(
                            id: 0,
                            imageUrl: '',
                            category: 'Desconocido',
                            name: 'Producto no encontrado',
                            price: 0,
                            stock: 0,
                            availableSizes: [],
                            availableColors: [],
                          ),
                    );

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2B2B2B),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amber.withOpacity(0.25),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          if (product.imageUrl.isNotEmpty)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                product.imageUrl,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Precio: \$${product.price.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  'Cantidad: ${item.cantidad}',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  'Subtotal: \$${item.subtotal?.toStringAsFixed(2) ?? "0.00"}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF18181B),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          const BoxShadow(
            color: Color(0xFFC59B2D),
            offset: Offset(0, 2),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color.fromARGB(199, 255, 255, 255),
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 26,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFFC59B2D),
                  offset: Offset(0, 2),
                  blurRadius: 3,
                ),
              ],
            ),
            child: Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
