// Ruta: lib/shared/widgets/added_product_item.dart

import 'package:flutter/material.dart';
import '../../data/models/product.dart';

class AddedProductItem extends StatelessWidget {
  final Map<String, dynamic> item;
  final void Function(Map<String, dynamic>) onAdd;
  final void Function(Map<String, dynamic>) onRemove;
  final void Function(Map<String, dynamic>) onDelete;
  final int index;

  const AddedProductItem({
    super.key,
    required this.item,
    required this.onAdd,
    required this.onRemove,
    required this.onDelete,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final Product product = item['product'];
    final int quantity = item['quantity'];
    final String size = item['size'];
    final String color = item['color'];

    return Card(
      color: Colors.grey[850],
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ), // Padding ajustado
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 8,
      shadowColor: Colors.amberAccent.withOpacity(0.4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    product.imageUrl,
                    height: 70, // Altura ligeramente reducida
                    width: 70, // Ancho ligeramente reducido
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) => Container(
                          height: 70,
                          width: 70,
                          color: Colors.grey,
                          child: const Icon(
                            Icons.image_not_supported,
                            color: Colors.white54,
                          ),
                        ),
                  ),
                ),
                const SizedBox(width: 12), // Espacio reducido
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Producto ${index + 1}: ${product.name}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16, // Tamaño de fuente reducido
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Talla: $size',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ), // Tamaño de fuente reducido
                      ),
                      Text(
                        'Color: $color',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ), // Tamaño de fuente reducido
                      ),
                      Text(
                        'Cantidad: $quantity',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ), // Tamaño de fuente reducido
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Total: \$${(product.price * quantity).toStringAsFixed(2)} COP',
                        style: TextStyle(
                          color: Colors.amberAccent.shade200,
                          fontSize: 14, // Tamaño de fuente reducido
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.remove_circle_outline,
                    color: Colors.redAccent,
                  ),
                  iconSize: 26, // Tamaño de icono ligeramente reducido
                  onPressed: () => onRemove(item),
                  tooltip: 'Disminuir cantidad',
                ),
                const SizedBox(width: 6), // Espacio reducido
                IconButton(
                  icon: const Icon(
                    Icons.add_circle_outline,
                    color: Colors.greenAccent,
                  ),
                  iconSize: 26, // Tamaño de icono ligeramente reducido
                  onPressed: () => onAdd(item),
                  tooltip: 'Aumentar cantidad',
                ),
                const SizedBox(width: 6), // Espacio reducido
                IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.amberAccent,
                  ),
                  iconSize: 26, // Tamaño de icono ligeramente reducido
                  onPressed: () => onDelete(item),
                  tooltip: 'Eliminar producto',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
