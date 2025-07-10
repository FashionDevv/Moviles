import 'package:flutter/material.dart';
import 'package:moviles/presentation/screens/refund/API/refund_api.dart';
import 'package:moviles/presentation/screens/refund/models/RefundModel.dart';
import 'package:moviles/presentation/screens/refund/widgets/details_refund.dart';
import '../../../../../shared/widgets/ListCard.dart';


class RefundsList extends StatelessWidget {
  const RefundsList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RefundModel>>(
      future: RefundsApi().getAllRefunds(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No hay devoluciones registradas'));
        }

        final devoluciones = snapshot.data!;

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          itemCount: devoluciones.length,
          itemBuilder: (context, index) {
            final devolucion = devoluciones[index];
            return ListCard(
              numero: devolucion.codigoDevolucion.toString(),
              fecha: devolucion.fechaDevolucion.split("T").first,
              nombre: "Venta asociada #${devolucion.codigoVenta}",
              total: "\$${devolucion.total}",
              estado: devolucion.estado,
              bg: Colors.blueGrey.withOpacity(0.2), // Color neutro para todas
              txt: Colors.blueGrey,
              iconos: ['eye'],
              onIconPressed: (icon) {
                if (icon == 'eye') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Detailsrefund(refund: devolucion),
                    ),
                  );
                }
              },
            );
          },
        );
      },
    );
  }
}
