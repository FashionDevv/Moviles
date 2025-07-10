import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  final String numero;
  final String fecha;
  final String nombre;
  final String total;
  final String estado;
  final Color bg;
  final Color txt;
  final List<String> iconos;
  final Function(String icon)? onIconPressed;

  const ListCard({
    Key? key,
    required this.numero,
    required this.fecha,
    required this.nombre,
    required this.total,
    required this.estado,
    required this.bg,
    required this.txt,
    required this.iconos,
    this.onIconPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2B2B2B),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título y estado
          Row(
            children: [
              Text(
                '$numero',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  estado,
                  style: TextStyle(
                    color: txt,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Fecha
          Text(
            fecha,
            style: const TextStyle(color: Colors.white60, fontSize: 12),
          ),

          // Cliente
          Text(nombre, style: const TextStyle(color: Colors.white)),

          // Precio
          Text(
            total,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),

          // Íconos de acción
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              for (int i = 0; i < iconos.length; i++) ...[
                if (i != 0) const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => onIconPressed?.call(iconos[i]),
                  child: _buildIcon(iconos[i]),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(String icono) {
    switch (icono) {
      case 'eye':
        return const Icon(Icons.remove_red_eye, color: Colors.blue);
      case 'upload':
        return const Icon(Icons.upload, color: Colors.white);
      case 'close':
        return const Icon(Icons.close, color: Colors.red);
      default:
        return const SizedBox.shrink();
    }
  }
}
