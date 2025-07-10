// OrdersScreen.dart
import 'package:flutter/material.dart';
import '../../../shared/layouts/BaseLayout.dart';
import 'widgets/buttons/add_button.dart';
import 'widgets/list/order_list.dart';
import 'widgets/forms/add_order.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  UniqueKey _refreshKey = UniqueKey();

  void _refreshOrders() {
    setState(() {
      _refreshKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Pedidos',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: PrimaryButton(
              text: 'Agregar Pedido',
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddOrder()),
                );
                _refreshOrders();
              },
            ),
          ),
          Expanded(child: OrdersList(key: _refreshKey)),
        ],
      ),
    );
  }
}
