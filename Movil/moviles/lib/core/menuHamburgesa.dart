import 'package:flutter/material.dart';

class AppDrawerFullScreen extends StatelessWidget {
  const AppDrawerFullScreen({super.key});

  final Color gold = const Color(0xFFFFEA00);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              color: const Color(0xFF1E1E1E),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Center(
                    child: Text(
                      'FashionLab',
                      style: TextStyle(
                        color: Color(0xFFFFEA00),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close, color: Color(0xFFFFEA00)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Center(
              child: Text(
                'HOME PAGES',
                style: TextStyle(
                  color: Color(0xFFFFEA00),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ExpansionTile(
              leading: Icon(Icons.shopping_bag_outlined, color: gold),
              title: Text(
                'Compras',
                style: TextStyle(color: gold, fontWeight: FontWeight.w600),
              ),
              iconColor: gold,
              collapsedIconColor: gold,
              childrenPadding: const EdgeInsets.only(left: 24),
              children: [
                ListTile(
                  leading: Icon(Icons.inventory_2, color: gold),
                  title: const Text(
                    'Productos',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap:
                      () => Navigator.pushNamed(context, '/compras/productos'),
                ),
                ListTile(
                  leading: Icon(Icons.category, color: gold),
                  title: const Text(
                    'Categoría Productos',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap:
                      () => Navigator.pushNamed(context, '/compras/categorias'),
                ),
              ],
            ),
            ExpansionTile(
              leading: Icon(Icons.storefront_outlined, color: gold),
              title: Text(
                'Ventas',
                style: TextStyle(color: gold, fontWeight: FontWeight.w600),
              ),
              iconColor: gold,
              collapsedIconColor: gold,
              childrenPadding: const EdgeInsets.only(left: 24),
              children: [
                ListTile(
                  leading: Icon(Icons.list_alt, color: gold),
                  title: const Text(
                    'Pedidos',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () => Navigator.pushNamed(context, '/ventas/pedidos'),
                ),
                ListTile(
                  leading: Icon(Icons.undo, color: gold),
                  title: const Text(
                    'Devoluciones',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap:
                      () =>
                          Navigator.pushNamed(context, '/ventas/devoluciones'),
                ),
              ],
            ),
            const Spacer(),
            ListTile(
              leading: Icon(Icons.logout, color: gold),
              title: const Text(
                'Cerrar sesión',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: const Color(0xFF1E1E1E),
                      title: const Text(
                        '¡Hasta pronto!',
                        style: TextStyle(color: Color(0xFFFFEA00)),
                      ),
                      content: const Text(
                        'Gracias por visitar FashionLab. ¡Te esperamos pronto!',
                        style: TextStyle(color: Colors.white),
                      ),
                      actions: [
                        TextButton(
                          child: const Text(
                            'Cerrar sesión',
                            style: TextStyle(color: Color(0xFFFFEA00)),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(); 
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/login',
                              (route) => false,
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
