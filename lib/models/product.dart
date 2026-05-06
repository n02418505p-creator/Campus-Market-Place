// lib/models/product.dart
// Created by: Caroline T. Maposa
// Student ID: N02424514M

class Product {
  final int id;
  final String name;
  final double price;
  final String category;
  final String image;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    this.image = '',
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      price: map['price'].toDouble(),
      category: map['category'] ?? 'Uncategorized',
      image: map['image'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'category': category,
      'image': image,
    };
  }
}
