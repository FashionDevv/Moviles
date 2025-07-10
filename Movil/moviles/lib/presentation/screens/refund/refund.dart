// RefundsScreen.dart
import 'package:flutter/material.dart';
import 'package:moviles/presentation/screens/orders/widgets/buttons/add_button.dart';
import 'package:moviles/presentation/screens/refund/list/refund_list.dart';
import 'package:moviles/presentation/screens/refund/widgets/buttons/AddRefund.dart';
import '../../../shared/layouts/BaseLayout.dart';


class RefundsScreen extends StatefulWidget {
  const RefundsScreen({super.key});

  @override
  State<RefundsScreen> createState() => _RefundsScreenState();
}

class _RefundsScreenState extends State<RefundsScreen> {
  UniqueKey _refreshKey = UniqueKey();

  void _refreshRefunds() {
    setState(() {
      _refreshKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Devoluciones',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: PrimaryButton(
              text: 'Agregar Devolución',
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddRefund()),
                );
                _refreshRefunds();
              },
            ),
          ),
          Expanded(child: RefundsList(key: _refreshKey)),
        ],
      ),
    );
  }
}
