// Ruta: lib/shared/widgets/ProductCard.dart

import 'package:flutter/material.dart';
import '../../data/models/product.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final Function(Product, String, String, int) onAdd;

  const ProductCard({super.key, required this.product, required this.onAdd});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  String? selectedSize;
  String? selectedColor;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    selectedSize =
        widget.product.availableSizes.isNotEmpty
            ? widget.product.availableSizes.first
            : null;
    selectedColor =
        widget.product.availableColors.isNotEmpty
            ? widget.product.availableColors.first
            : null;
  }

  @override
  void didUpdateWidget(covariant ProductCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.product.availableSizes.contains(selectedSize)) {
      selectedSize =
          widget.product.availableSizes.isNotEmpty
              ? widget.product.availableSizes.first
              : null;
    }
    if (!widget.product.availableColors.contains(selectedColor)) {
      selectedColor =
          widget.product.availableColors.isNotEmpty
              ? widget.product.availableColors.first
              : null;
    }
  }

  void _incrementQuantity() {
    setState(() {
      if (_quantity < widget.product.stock) {
        _quantity++;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No hay más stock disponible para este producto.'),
          ),
        );
      }
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      shadowColor: Colors.amberAccent.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                widget.product.imageUrl,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) => Container(
                      height: 100,
                      width: double.infinity,
                      color: Colors.grey,
                      child: const Icon(
                        Icons.image_not_supported,
                        color: Colors.white54,
                      ),
                      alignment: Alignment.center,
                    ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.product.category.toUpperCase(),
              style: TextStyle(
                color: Colors.amberAccent.shade400,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.product.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 5,
                    color: Colors.black45,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              'Precio: \$${widget.product.price.toStringAsFixed(2)} COP',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'Talla: ',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: DropdownButton<String>(
                    dropdownColor: Colors.grey[850],
                    value:
                        widget.product.availableSizes.contains(selectedSize)
                            ? selectedSize
                            : null,
                    style: const TextStyle(color: Colors.white),
                    underline: Container(height: 2, color: Colors.amberAccent),
                    isExpanded: true,
                    items:
                        widget.product.availableSizes
                            .map(
                              (size) => DropdownMenuItem(
                                value: size,
                                child: Text(size),
                              ),
                            )
                            .toList(),
                    onChanged: (value) => setState(() => selectedSize = value),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Color: ',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: DropdownButton<String>(
                    dropdownColor: Colors.grey[850],
                    value:
                        widget.product.availableColors.contains(selectedColor)
                            ? selectedColor
                            : null,
                    style: const TextStyle(color: Colors.white),
                    underline: Container(height: 2, color: Colors.amberAccent),
                    isExpanded: true,
                    items:
                        widget.product.availableColors
                            .map(
                              (color) => DropdownMenuItem(
                                value: color,
                                child: Text(color),
                              ),
                            )
                            .toList(),
                    onChanged: (value) => setState(() => selectedColor = value),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Stock disponible: ${widget.product.stock}',
              style: const TextStyle(color: Colors.white54, fontSize: 12),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.amberAccent.withOpacity(0.5),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: _decrementQuantity,
                        child: const Icon(
                          Icons.remove,
                          color: Colors.redAccent,
                          size: 22,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          _quantity.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: _incrementQuantity,
                        child: const Icon(
                          Icons.add,
                          color: Colors.greenAccent,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amberAccent.shade400,
                    foregroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    elevation: 5,
                    shadowColor: Colors.amberAccent.withOpacity(0.6),
                  ),
                  icon: const Icon(Icons.shopping_cart_checkout, size: 20),
                  label: const Text('Agregar', style: TextStyle(fontSize: 14)),
                  onPressed: () {
                    if (selectedSize != null && selectedColor != null) {
                      widget.onAdd(
                        widget.product,
                        selectedSize!,
                        selectedColor!,
                        _quantity,
                      );
                      setState(() {
                        _quantity = 1;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Por favor, selecciona talla y color.'),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
