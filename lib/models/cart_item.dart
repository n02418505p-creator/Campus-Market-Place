// lib/models/cart_item.dart
// Created by: Tinoidaishe Mwenga
// Student ID: N02422373H

import 'product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  double get subtotal => product.price * quantity;

  Map<String, dynamic> toMap() {
    return {
      'product_id': product.id,
      'quantity': quantity,
    };
  }
}
