import '../../models/product.dart';

final List<Product> sampleProducts = [
  Product(
    id: 01,
    imageUrl:
        'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=400&h=400&fit=crop',
    category: 'Fashion',
    name: 'Zapatos Nikes Deportivos Pro',
    price: 180000.00,
    stock: 50,
    availableSizes: ['38', '39', '40', '41', '42', '43'],
    availableColors: ['Rojo', 'Negro', 'Blanco'],
  ),
  Product(
    id: 02,
    imageUrl:
        'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=400&h=400&fit=crop',
    category: 'Tecnología',
    name: 'Teclado Mecánico RGB GXT',
    price: 55000.00,
    stock: 20,
    availableSizes: ['Estándar'],
    availableColors: ['Negro', 'Blanco'],
  ),
  Product(
    id: 03,
    imageUrl:
        'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=400&h=400&fit=crop',
    category: 'Hogar',
    name: 'Cafetera Expreso Italiana',
    price: 120000.00,
    stock: 15,
    availableSizes: ['Unica'],
    availableColors: ['Plateado', 'Negro'],
  ),
  Product(
    id: 04,
    imageUrl:
        'https://images.unsplash.com/photo-1551698618-1dfe5d97d256?w=400&h=400&fit=crop',
    category: 'Deportes',
    name: 'Balón de Fútbol Profesional',
    price: 35000.00,
    stock: 30,
    availableSizes: ['Talla 5'],
    availableColors: ['Blanco/Negro', 'Amarillo'],
  ),
  Product(
    id: 05,
    imageUrl:
        'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400&h=400&fit=crop',
    category: 'Electrónica',
    name: 'Audífonos Inalámbricos Pro Max',
    price: 95000.00,
    stock: 25,
    availableSizes: ['Única'],
    availableColors: ['Negro', 'Gris Espacial', 'Azul'],
  ),
];
