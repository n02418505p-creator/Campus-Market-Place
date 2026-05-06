// // lib/screens/checkout_screen.dart
// Created by: Blessings Hoto
// Student ID: N02423763T

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../services/auth_service.dart';
import '../services/cart_service.dart';
import '../services/database_service.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  String _paymentMethod = 'Credit Card';
  bool _isProcessing = false;

  final List<String> _paymentMethods = [
    'Credit Card',
    'Debit Card',
    'Cash on Delivery',
    'Mobile Money',
  ];

  Future<void> _placeOrder() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isProcessing = true);
    
    final authService = Provider.of<AuthService>(context, listen: false);
    final cartService = Provider.of<CartService>(context, listen: false);
    final dbService = DatabaseService.instance;
    
    final orderDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    
    await dbService.insert('orders', {
      'username': authService.currentUser,
      'address': _addressController.text.trim(),
      'total_amount': cartService.totalAmount,
      'payment_method': _paymentMethod,
      'order_date': orderDate,
    });
    
    final userResult = await dbService.query(
      'users',
      where: 'username = ?',
      whereArgs: [authService.currentUser],
    );
    if (userResult.isNotEmpty) {
      await cartService.clearCart(userResult.first['id'] as int);
    }
    
    setState(() => _isProcessing = false);
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Color(0xFF17A2B8)),
            SizedBox(width: 8),
            Text('Order Confirmed!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Thank you for your purchase!'),
            const SizedBox(height: 16),
            Text('Order Date: $orderDate'),
            Text('Total: \$${cartService.totalAmount.toStringAsFixed(2)}'),
            Text('Payment: $_paymentMethod'),
            const SizedBox(height: 16),
            const Text('You will receive a confirmation email shortly.'),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/home');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E88E5),
            ),
            child: const Text('Continue Shopping'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartService = Provider.of<CartService>(context);
    
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: const Color(0xFF17A2B8),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Order Summary',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0B3C5D),
                        ),
                      ),
                      const Divider(),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartService.cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartService.cartItems[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    '${item.product.name} x${item.quantity}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                                Text(
                                  '\$${item.subtotal.toStringAsFixed(2)}',
                                  style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF17A2B8)),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const Divider(),
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
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF17A2B8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Delivery Address',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0B3C5D),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _addressController,
                        decoration: const InputDecoration(
                          labelText: 'Address',
                          prefixIcon: Icon(Icons.location_on_outlined, color: Color(0xFF0B3C5D)),
                        ),
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your delivery address';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Payment Method',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0B3C5D),
                        ),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _paymentMethod,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.payment, color: Color(0xFF0B3C5D)),
                        ),
                        items: _paymentMethods.map((method) {
                          return DropdownMenuItem(
                            value: method,
                            child: Text(method),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _paymentMethod = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isProcessing ? null : _placeOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E88E5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isProcessing
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Place Order'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }
}
// Created by: Owen K. Murewa
// Student ID: N02419341C

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import '../../services/database_service.dart';
import '../../models/product.dart';
import '../../widgets/product_image.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  List<Product> _products = [];
  List<Map<String, dynamic>> _orders = [];
  int _selectedTab = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final dbService = DatabaseService.instance;
    
    final productsData = await dbService.query('products');
    final ordersData = await dbService.query('orders', orderBy: 'order_date DESC');
    
    setState(() {
      _products = productsData.map((p) => Product.fromMap(p)).toList();
      _orders = ordersData;
      _isLoading = false;
    });
  }

  Future<void> _deleteProduct(int productId) async {
    final dbService = DatabaseService.instance;
    await dbService.delete('products', where: 'id = ?', whereArgs: [productId]);
    await _loadData();
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Product deleted'), backgroundColor: Colors.red),
    );
  }

  Future<void> _deleteOrder(int orderId) async {
    final dbService = DatabaseService.instance;
    await dbService.delete('orders', where: 'id = ?', whereArgs: [orderId]);
    await _loadData();
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Order deleted'), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    
    if (!authService.isAdmin) {
      return Scaffold(
        backgroundColor: const Color(0xFFEDEDED),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text('Access Denied', style: TextStyle(color: Color(0xFF0B3C5D))),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  authService.logout();
                  Navigator.pushReplacementNamed(context, '/');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E88E5),
                ),
                child: const Text('Go to Login'),
              ),
            ],
          ),
        ),
      );
    }
    
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: const Color(0xFF17A2B8),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authService.logout();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildTab('Products', 0),
                      ),
                      Expanded(
                        child: _buildTab('Orders', 1),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _selectedTab == 0
                      ? _buildProductsTab()
                      : _buildOrdersTab(),
                ),
              ],
            ),
      floatingActionButton: _selectedTab == 0
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.pushNamed(context, '/add-product').then((_) => _loadData());
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Product'),
              backgroundColor: const Color(0xFF1E88E5),
            )
          : null,
    );
  }

  Widget _buildTab(String label, int index) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? const Color(0xFF17A2B8) : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? const Color(0xFF17A2B8) : Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildProductsTab() {
    if (_products.isEmpty) {
      return const Center(child: Text('No products found', style: TextStyle(color: Color(0xFF0B3C5D))));
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        final product = _products[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: SizedBox(
              width: 50,
              height: 50,
              child: ProductImage(
                imagePath: product.image.isNotEmpty ? product.image : 'assets/images/placeholder.jpg',
                height: 50,
                width: 50,
              ),
            ),
            title: Text(product.name, style: const TextStyle(color: Color(0xFF0B3C5D))),
            subtitle: Text('\$${product.price.toStringAsFixed(2)} • ${product.category}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteProduct(product.id),
            ),
          ),
        );
      },
    );
  }

  Widget _buildOrdersTab() {
    if (_orders.isEmpty) {
      return const Center(child: Text('No orders found', style: TextStyle(color: Color(0xFF0B3C5D))));
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _orders.length,
      itemBuilder: (context, index) {
        final order = _orders[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: const Icon(Icons.receipt, color: Color(0xFF17A2B8)),
            title: Text('Order #${order['id']} - ${order['username']}', style: const TextStyle(color: Color(0xFF0B3C5D))),
            subtitle: Text(
              '${order['order_date']} • \$${order['total_amount']}',
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteOrder(order['id'] as int),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Order #${order['id']}', style: const TextStyle(color: Color(0xFF0B3C5D))),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Customer: ${order['username']}'),
                      const SizedBox(height: 8),
                      Text('Address: ${order['address']}'),
                      const SizedBox(height: 8),
                      Text('Payment: ${order['payment_method']}'),
                      const SizedBox(height: 8),
                      Text('Date: ${order['order_date']}'),
                      const Divider(),
                      Text(
                        'Total: \$${order['total_amount']}',
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF17A2B8)),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
