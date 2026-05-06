// lib/screens/cart_screen.dart
// Created by: Buhlebenkosi Ncube
// Student ID: N02428404M

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/cart_service.dart';
import '../services/database_service.dart';
import '../models/cart_item.dart';
import '../widgets/product_image.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  Future<void> _loadCart() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final cartService = Provider.of<CartService>(context, listen: false);
    
    final dbService = DatabaseService.instance;
    final userResult = await dbService.query(
      'users',
      where: 'username = ?',
      whereArgs: [authService.currentUser],
    );
    
    if (userResult.isNotEmpty) {
      await cartService.loadCart(userResult.first['id'] as int);
    }
    
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final cartService = Provider.of<CartService>(context);
    
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      appBar: AppBar(
        title: const Text('My Cart'),
        backgroundColor: const Color(0xFF17A2B8),
        actions: [
          if (cartService.cartItems.isNotEmpty)
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Clear Cart'),
                    content: const Text('Are you sure you want to clear your cart?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          final authService = Provider.of<AuthService>(context, listen: false);
                          final dbService = DatabaseService.instance;
                          final userResult = await dbService.query(
                            'users',
                            where: 'username = ?',
                            whereArgs: [authService.currentUser],
                          );
                          if (userResult.isNotEmpty) {
                            await cartService.clearCart(userResult.first['id'] as int);
                          }
                          Navigator.pop(context);
                        },
                        child: const Text('Clear', style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Clear', style: TextStyle(color: Colors.white)),
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : cartService.cartItems.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'Your cart is empty',
                        style: TextStyle(fontSize: 18, color: Color(0xFF0B3C5D)),
                      ),
                      SizedBox(height: 8),
                      Text('Start shopping to add items'),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: cartService.cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartService.cartItems[index];
                          return _buildCartItem(item);
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            offset: const Offset(0, -2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total:',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0B3C5D),
                                ),
                              ),
                              Text(
                                '\$${cartService.totalAmount.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF17A2B8),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/checkout');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1E88E5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text('Proceed to Checkout'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF17A2B8),
        unselectedItemColor: Colors.grey,
        currentIndex: 2,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Products'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/products');
              break;
            case 3:
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
      ),
    );
  }

  Widget _buildCartItem(CartItem item) {
    final cartService = Provider.of<CartService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: ProductImage(
                imagePath: item.product.image.isNotEmpty ? item.product.image : 'assets/images/placeholder.jpg',
                height: 80,
                width: 80,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF0B3C5D),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${item.product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Color(0xFF17A2B8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline, color: Color(0xFF17A2B8)),
                        onPressed: () async {
                          final dbService = DatabaseService.instance;
                          final userResult = await dbService.query(
                            'users',
                            where: 'username = ?',
                            whereArgs: [authService.currentUser],
                          );
                          if (userResult.isNotEmpty) {
                            await cartService.updateQuantity(
                              userResult.first['id'] as int,
                              item.product.id,
                              item.quantity - 1,
                            );
                          }
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        item.quantity.toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline, color: Color(0xFF17A2B8)),
                        onPressed: () async {
                          final dbService = DatabaseService.instance;
                          final userResult = await dbService.query(
                            'users',
                            where: 'username = ?',
                            whereArgs: [authService.currentUser],
                          );
                          if (userResult.isNotEmpty) {
                            await cartService.updateQuantity(
                              userResult.first['id'] as int,
                              item.product.id,
                              item.quantity + 1,
                            );
                          }
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  '\$${item.subtotal.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF17A2B8),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () async {
                    final dbService = DatabaseService.instance;
                    final userResult = await dbService.query(
                      'users',
                      where: 'username = ?',
                      whereArgs: [authService.currentUser],
                    );
                    if (userResult.isNotEmpty) {
                      await cartService.removeFromCart(
                        userResult.first['id'] as int,
                        item.product.id,
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
