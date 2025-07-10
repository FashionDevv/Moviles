import 'package:flutter/material.dart';
import 'package:moviles/data/DTOs/new_order_dto.dart';
import 'package:moviles/shared/layouts/BaseLayout.dart';
import '../../../../../data/datasources/orders/products_data.dart';
import '../../../../../data/datasources/orders/orders_api.dart';
import '../../../../../data/models/product.dart';
import '../../../../../data/models/order_product_model.dart';
import '../../../../../shared/widgets/ProductCard.dart';
import '../../../../../shared/widgets/AddedProductCarousel.dart';

class AddOrder extends StatefulWidget {
  const AddOrder({super.key});

  @override
  State<AddOrder> createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  String selectedClient = 'Jose Torres';
  String searchQuery = '';
  final List<Map<String, dynamic>> addedItems = [];

  final PageController _productPageController = PageController(
    viewportFraction: 1.0,
  );

  void addProduct(
    Product product,
    String size,
    String color,
    int quantityToAdd,
  ) {
    final index = addedItems.indexWhere(
      (item) =>
          item['product'].id == product.id &&
          item['size'] == size &&
          item['color'] == color,
    );

    setState(() {
      if (index != -1) {
        final currentQty = addedItems[index]['quantity'];
        final maxStock = (addedItems[index]['product'] as Product).stock;
        if (currentQty + quantityToAdd <= maxStock) {
          addedItems[index]['quantity'] = currentQty + quantityToAdd;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'No se puede agregar más de ${maxStock - currentQty} unidades de ${product.name}.',
              ),
            ),
          );
        }
      } else {
        if (quantityToAdd <= product.stock) {
          addedItems.add({
            'product': product,
            'size': size,
            'color': color,
            'quantity': quantityToAdd,
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('No hay suficiente stock para ${product.name}.'),
            ),
          );
        }
      }
    });
  }

  void updateQuantity(Map<String, dynamic> item, int change) {
    final index = addedItems.indexOf(item);
    if (index != -1) {
      final currentQty = addedItems[index]['quantity'];
      final maxStock = (addedItems[index]['product'] as Product).stock;
      final newQty = currentQty + change;
      if (newQty > 0 && newQty <= maxStock) {
        setState(() => addedItems[index]['quantity'] = newQty);
      } else if (newQty <= 0) {
        removeProduct(item);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No hay más stock disponible.')),
        );
      }
    }
  }

  void removeProduct(Map<String, dynamic> item) {
    setState(() => addedItems.remove(item));
  }

  @override
  void dispose() {
    _productPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts =
        sampleProducts.where((product) {
          final name = product.name.toLowerCase();
          final query = searchQuery.trim().toLowerCase();
          return query.isEmpty || name.contains(query);
        }).toList();

    return BaseLayout(
      title: 'Agregar Pedido',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Cliente',
                filled: true,
                fillColor: Colors.white10,
                labelStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              dropdownColor: Colors.grey[900],
              value: selectedClient,
              items:
                  ['Jose Torres', 'Cliente 2']
                      .map(
                        (name) => DropdownMenuItem(
                          value: name,
                          child: Text(
                            name,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                      .toList(),
              onChanged: (value) => setState(() => selectedClient = value!),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar producto...',
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                filled: true,
                fillColor: Colors.white10,
                hintStyle: const TextStyle(color: Colors.white70),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              'Productos Disponibles',
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(color: Colors.amber),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 380,
              child:
                  filteredProducts.isEmpty
                      ? const Center(
                        child: Text(
                          'No se encontraron productos.',
                          style: TextStyle(color: Colors.white54, fontSize: 16),
                        ),
                      )
                      : PageView.builder(
                        controller: _productPageController,
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          return ProductCard(
                            product: product,
                            onAdd: addProduct,
                          );
                        },
                      ),
            ),
            const SizedBox(height: 20),
            if (addedItems.isNotEmpty) ...[
              Text(
                'Productos Agregados',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(color: Colors.amber),
              ),
              const SizedBox(height: 8),
              AddedProductCarousel(
                addedItems: addedItems,
                onAdd: (item) => updateQuantity(item, 1),
                onRemove: (item) => updateQuantity(item, -1),
                onDelete: removeProduct,
              ),
            ],
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () async {
                  if (addedItems.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Debes agregar al menos un producto al pedido.',
                        ),
                      ),
                    );
                    return;
                  }

                  try {
                    final productos =
                        addedItems.map((item) {
                          final product = item['product'] as Product;
                          return OrderProductModel(
                            codigoPTC: product.id,
                            precioUnitario: product.price,
                            cantidad: item['quantity'],
                            subtotal: product.price * item['quantity'],
                            codigoVenta: null,
                          );
                        }).toList();

                    final newOrder = NewOrderDTO(
                      fechaVenta: DateTime.now().toIso8601String(),
                      idCliente: selectedClient == 'Jose Torres' ? 1 : 2,
                      tipoVenta: 'Pedido',
                      estado: 'Pendiente',
                      ventaProductos: productos,
                    );

                    await OrdersApi().addOrder(newOrder);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Pedido agregado correctamente'),
                        backgroundColor: Colors.green,
                      ),
                    );

                    setState(() => addedItems.clear());
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error al agregar el pedido: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Agregar Pedido',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
