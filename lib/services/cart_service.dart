// lib/services/cart_service.dart
// Created by: Denzel Joe
// Student ID: N02427776H

import 'package:flutter/material.dart';
import 'database_service.dart';
import '../models/product.dart';
import '../models/cart_item.dart';

class CartService extends ChangeNotifier {
  List<CartItem> _cartItems = [];
  
  List<CartItem> get cartItems => _cartItems;
  int get itemCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);
  double get totalAmount => _cartItems.fold(0.0, (sum, item) => sum + item.subtotal);

  Future<void> loadCart(int userId) async {
    final dbService = DatabaseService.instance;
    final result = await dbService.rawQuery('''
      SELECT cart.quantity, products.* 
      FROM cart 
      JOIN products ON cart.product_id = products.id 
      WHERE cart.user_id = ?
    ''', [userId]);
    
    _cartItems = result.map((row) {
      return CartItem(
        product: Product.fromMap(row),
        quantity: row['quantity'] as int,
      );
    }).toList();
    
    notifyListeners();
  }

  Future<void> addToCart(int userId, Product product) async {
    final dbService = DatabaseService.instance;
    
    final existingIndex = _cartItems.indexWhere((item) => item.product.id == product.id);
    
    if (existingIndex != -1) {
      _cartItems[existingIndex].quantity++;
      await dbService.update(
        'cart',
        {'quantity': _cartItems[existingIndex].quantity},
        where: 'user_id = ? AND product_id = ?',
        whereArgs: [userId, product.id],
      );
    } else {
      _cartItems.add(CartItem(product: product));
      await dbService.insert('cart', {
        'user_id': userId,
        'product_id': product.id,
        'quantity': 1,
      });
    }
    
    notifyListeners();
  }

  Future<void> removeFromCart(int userId, int productId) async {
    final dbService = DatabaseService.instance;
    
    _cartItems.removeWhere((item) => item.product.id == productId);
    await dbService.delete(
      'cart',
      where: 'user_id = ? AND product_id = ?',
      whereArgs: [userId, productId],
    );
    
    notifyListeners();
  }

  Future<void> updateQuantity(int userId, int productId, int quantity) async {
    final dbService = DatabaseService.instance;
    
    final index = _cartItems.indexWhere((item) => item.product.id == productId);
    if (index != -1) {
      if (quantity <= 0) {
        await removeFromCart(userId, productId);
      } else {
        _cartItems[index].quantity = quantity;
        await dbService.update(
          'cart',
          {'quantity': quantity},
          where: 'user_id = ? AND product_id = ?',
          whereArgs: [userId, productId],
        );
      }
    }
    
    notifyListeners();
  }

  Future<void> clearCart(int userId) async {
    final dbService = DatabaseService.instance;
    
    _cartItems.clear();
    await dbService.delete(
      'cart',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    
    notifyListeners();
  }
}
