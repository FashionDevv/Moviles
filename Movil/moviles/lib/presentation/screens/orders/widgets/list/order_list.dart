import 'package:flutter/material.dart';
import '../../../../../shared/widgets/ListCard.dart';
import '../../../../../data/datasources/orders/orders_api.dart';
import '../../../../../data/models/order_model.dart';
import '../forms/details_order.dart';

class OrdersList extends StatefulWidget {
  const OrdersList({super.key});

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  late Future<List<OrderModel>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _ordersFuture = OrdersApi().getAllOrders();
  }

  void _refreshOrders() {
    setState(() {
      _ordersFuture = OrdersApi().getAllOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<OrderModel>>(
      future: _ordersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No hay pedidos'));
        }

        final orders = snapshot.data!;
        final pendientes =
            orders.where((p) => p.estado == 'Pendiente').toList();
        final otros = orders.where((p) => p.estado != 'Pendiente').toList();

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          children: [
            if (pendientes.isNotEmpty) ...[
              const Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: Text(
                  'Se debe pagar en 24h el pedido para confirmarse',
                  style: TextStyle(
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              ...pendientes.map(
                (pedido) => ListCard(
                  numero: pedido.codigoVenta.toString(),
                  fecha: pedido.fechaVenta.split("T").first,
                  nombre: "Cliente ${pedido.idCliente}",
                  total: "\$${pedido.total}",
                  estado: pedido.estado,
                  bg: Colors.amber.withOpacity(0.2),
                  txt: Colors.amber,
                  iconos: ['eye', 'upload', 'close'],
                  onIconPressed: (icon) async {
                    if (icon == 'eye') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailsOrder(order: pedido),
                        ),
                      );
                    } else if (icon == 'close') {
                      final confirmado = await showDialog<bool>(
                        context: context,
                        builder:
                            (_) => AlertDialog(
                              title: const Text("Anular pedido"),
                              content: const Text(
                                "¿Estás seguro de anular este pedido?",
                              ),
                              actions: [
                                TextButton(
                                  onPressed:
                                      () => Navigator.pop(context, false),
                                  child: const Text("Cancelar"),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text("Anular"),
                                ),
                              ],
                            ),
                      );

                      if (confirmado == true) {
                        try {
                          await OrdersApi().changeOrderState(
                            saleCode: pedido.codigoVenta,
                            estado: 'Anulada',
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Pedido anulado')),
                          );

                          _refreshOrders();
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error al anular el pedido: $e'),
                            ),
                          );
                        }
                      }
                    }
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(color: Colors.white24, thickness: 1),
              ),
            ],
            ...otros.map(
              (pedido) => ListCard(
                numero: pedido.codigoVenta.toString(),
                fecha: pedido.fechaVenta.split("T").first,
                nombre: "Cliente ${pedido.idCliente}",
                total: "\$${pedido.total}",
                estado: pedido.estado,
                bg:
                    pedido.estado == 'Anulada'
                        ? Colors.red.withOpacity(0.2)
                        : Colors.green.withOpacity(0.2),
                txt: pedido.estado == 'Anulada' ? Colors.red : Colors.green,
                iconos: pedido.estado == 'Anulada' ? [] : ['eye', 'close'],
                onIconPressed: (icon) {
                  if (icon == 'eye') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailsOrder(order: pedido),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
