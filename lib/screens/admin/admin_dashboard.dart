// lib/screens/admin/admin_dashboard.dart
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
