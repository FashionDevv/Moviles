// Ruta: lib/shared/widgets/Added_Product.dart (o renómbralo a added_product_carousel.dart)

import 'package:flutter/material.dart';
import '../../data/models/product.dart';
import 'added_product_item.dart';

class AddedProductCarousel extends StatelessWidget {
  final List<Map<String, dynamic>> addedItems;
  final void Function(Map<String, dynamic>) onAdd;
  final void Function(Map<String, dynamic>) onRemove;
  final void Function(Map<String, dynamic>) onDelete;

  const AddedProductCarousel({
    super.key,
    required this.addedItems,
    required this.onAdd,
    required this.onRemove,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (addedItems.isEmpty) return const SizedBox.shrink();

    // Calculamos el total general de los productos agregados
    double grandTotal = addedItems.fold(0.0, (sum, item) {
      final product = item['product'] as Product;
      final quantity = item['quantity'] as int;
      return sum + (product.price * quantity);
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 230, // Altura ajustada para el carrusel de items
          child: PageView.builder(
            itemCount: addedItems.length,
            controller: PageController(viewportFraction: 0.95),
            itemBuilder: (context, index) {
              final item = addedItems[index];
              return AddedProductItem(
                // Usamos el nuevo widget de item
                item: item,
                onAdd: onAdd,
                onRemove: onRemove,
                onDelete: onDelete,
                index: index,
              );
            },
          ),
        ),
        const SizedBox(height: 16), // Espacio ajustado
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Total General: \$${grandTotal.toStringAsFixed(2)} COP',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Colors.amber,
              fontWeight: FontWeight.bold,
              fontSize: 20, // Tamaño de fuente ajustado
            ),
          ),
        ),
      ],
    );
  }
}
