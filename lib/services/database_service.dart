// lib/services/database_service.dart
// Created by: Sean Ncube
// Student ID: N02426665X

import 'package:flutter/foundation.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  
  List<Map<String, dynamic>> _users = [];
  List<Map<String, dynamic>> _products = [];
  List<Map<String, dynamic>> _cart = [];
  List<Map<String, dynamic>> _orders = [];
  
  int _nextUserId = 35;
  int _nextProductId = 26;
  int _nextCartId = 1;
  int _nextOrderId = 1;

  DatabaseService._init();

  Future<void> initDB() async {
    await _initSampleData();
  }

  DatabaseService get database => this;

  Future<void> _initSampleData() async {
    // ==================== ALL STUDENTS (30 users) ====================
    _users = [
      // Admin User
      {'id': 1, 'username': 'admin', 'password': 'admin123', 'role': 'admin'},
      
      // Class Students (10 users - from your list)
      {'id': 2, 'username': 'Buhlebenkosi', 'password': 'N02428404M', 'role': 'student'},
      {'id': 3, 'username': 'Collins', 'password': 'N02424587C', 'role': 'student'},
      {'id': 4, 'username': 'Denzel', 'password': 'N0242776H', 'role': 'student'},
      {'id': 5, 'username': 'Blessings', 'password': 'N02423763T', 'role': 'student'},
      {'id': 6, 'username': 'Kundai', 'password': 'N02423683W', 'role': 'student'},
      {'id': 7, 'username': 'Owen', 'password': 'N02419341C', 'role': 'student'},
      {'id': 8, 'username': 'Tinoidaishe', 'password': 'N02422373H', 'role': 'student'},
      {'id': 9, 'username': 'Caroline', 'password': 'N02424514M', 'role': 'student'},
      {'id': 10, 'username': 'Sean', 'password': 'N02426665X', 'role': 'student'},
      {'id': 11, 'username': 'Takudzwa', 'password': 'N02418505P', 'role': 'student'},
      
      // Additional Students from Campus (20 users)
      {'id': 12, 'username': 'Tanaka', 'password': 'NUST2024001', 'role': 'student'},
      {'id': 13, 'username': 'Rutendo', 'password': 'NUST2024002', 'role': 'student'},
      {'id': 14, 'username': 'Kudakwashe', 'password': 'NUST2024003', 'role': 'student'},
      {'id': 15, 'username': 'Tafadzwa', 'password': 'NUST2024004', 'role': 'student'},
      {'id': 16, 'username': 'Munashe', 'password': 'NUST2024005', 'role': 'student'},
      {'id': 17, 'username': 'Anotida', 'password': 'NUST2024006', 'role': 'student'},
      {'id': 18, 'username': 'Tinashe', 'password': 'NUST2024007', 'role': 'student'},
      {'id': 19, 'username': 'Rumbidzai', 'password': 'NUST2024008', 'role': 'student'},
      {'id': 20, 'username': 'Nyasha', 'password': 'NUST2024009', 'role': 'student'},
      {'id': 21, 'username': 'Makanaka', 'password': 'NUST2024010', 'role': 'student'},
      {'id': 22, 'username': 'Tawananyasha', 'password': 'NUST2024011', 'role': 'student'},
      {'id': 23, 'username': 'Panashe', 'password': 'NUST2024012', 'role': 'student'},
      {'id': 24, 'username': 'Ruvimbo', 'password': 'NUST2024013', 'role': 'student'},
      {'id': 25, 'username': 'Tadiwanashe', 'password': 'NUST2024014', 'role': 'student'},
      {'id': 26, 'username': 'Tanyaradzwa', 'password': 'NUST2024015', 'role': 'student'},
      {'id': 27, 'username': 'Mufaro', 'password': 'NUST2024016', 'role': 'student'},
      {'id': 28, 'username': 'Ropafadzo', 'password': 'NUST2024017', 'role': 'student'},
      {'id': 29, 'username': 'Kudzai', 'password': 'NUST2024018', 'role': 'student'},
      {'id': 30, 'username': 'Tendai', 'password': 'NUST2024019', 'role': 'student'},
      {'id': 31, 'username': 'Chipo', 'password': 'NUST2024020', 'role': 'student'},
    ];
    _nextUserId = 32;

    // ==================== PRODUCTS ====================
    _products = [
      // Bags
      {'id': 1, 'name': 'Leather Satchel', 'price': 45.0, 'category': 'Bags', 'image': 'assets/images/satchel.jpg'},
      {'id': 2, 'name': 'Canvas Backpack', 'price': 28.0, 'category': 'Bags', 'image': 'assets/images/backpack.jpg'},
      
      // Clothing
      {'id': 3, 'name': 'NUST Cap', 'price': 15.0, 'category': 'Clothing', 'image': 'assets/images/cap.jpg'},
      {'id': 4, 'name': 'Wool Scarf', 'price': 20.0, 'category': 'Clothing', 'image': 'assets/images/scarf.jpg'},
      {'id': 5, 'name': 'NUST T-Shirt', 'price': 15.0, 'category': 'Clothing', 'image': 'assets/images/tshirt.jpg'},
      {'id': 6, 'name': 'NUST Hoodie', 'price': 35.0, 'category': 'Clothing', 'image': 'assets/images/hoodie.jpg'},
      {'id': 7, 'name': 'Dark Blue T-Shirt', 'price': 15.0, 'category': 'Clothing', 'image': 'assets/images/db_t-shirt.jpg'},
      {'id': 8, 'name': 'NUST Sweater', 'price': 30.0, 'category': 'Clothing', 'image': 'assets/images/sweater.jpg'},
      
      // Stationery
      {'id': 9, 'name': 'NUST Pen Set', 'price': 8.0, 'category': 'Stationery', 'image': 'assets/images/pen.jpg'},
      {'id': 10, 'name': 'Planner Diary', 'price': 10.0, 'category': 'Stationery', 'image': 'assets/images/diary.jpg'},
      {'id': 11, 'name': 'Notebook', 'price': 3.0, 'category': 'Stationery', 'image': 'assets/images/notebook.jpg'},
      {'id': 12, 'name': 'Office Supplies Kit', 'price': 12.0, 'category': 'Stationery', 'image': 'assets/images/office.jpg'},
      
      // Food
      {'id': 13, 'name': 'Biscuits', 'price': 2.0, 'category': 'Food', 'image': 'assets/images/biscuits.jpg'},
      {'id': 14, 'name': 'Chips', 'price': 1.5, 'category': 'Food', 'image': 'assets/images/chips.jpg'},
      {'id': 15, 'name': 'Chocolates', 'price': 3.0, 'category': 'Food', 'image': 'assets/images/chocolates.jpg'},
      
      // Drinks
      {'id': 16, 'name': 'Juice', 'price': 2.5, 'category': 'Drinks', 'image': 'assets/images/juice.jpg'},
      {'id': 17, 'name': 'Fizzy Drink', 'price': 1.8, 'category': 'Drinks', 'image': 'assets/images/fizzy.jpg'},
      {'id': 18, 'name': 'NUST Coffee Mug', 'price': 8.0, 'category': 'Drinks', 'image': 'assets/images/mug.jpg'},
      
      // Electronics
      {'id': 19, 'name': 'Student Laptop', 'price': 450.0, 'category': 'Electronics', 'image': 'assets/images/laptop.jpg'},
      {'id': 20, 'name': 'Tech Accessories', 'price': 25.0, 'category': 'Electronics', 'image': 'assets/images/tech.jpg'},
      
      // Graduation
      {'id': 21, 'name': 'Graduation Gown', 'price': 85.0, 'category': 'Graduation', 'image': 'assets/images/graduation.jpg'},
      
      // Accessories
      {'id': 22, 'name': 'Keychain Set', 'price': 5.0, 'category': 'Accessories', 'image': 'assets/images/keyholder.jpg'},
      
      // Souvenirs
      {'id': 23, 'name': 'NUST Souvenirs', 'price': 10.0, 'category': 'Souvenirs', 'image': 'assets/images/souvenirs.jpg'},
      
      // Books
      {'id': 24, 'name': 'Textbooks Set', 'price': 45.0, 'category': 'Books', 'image': 'assets/images/textbooks.jpg'},
      
      // Dorm Essentials
      {'id': 25, 'name': 'Dorm Essentials Kit', 'price': 25.0, 'category': 'Bags', 'image': 'assets/images/dorm.jpg'},
    ];
    _nextProductId = 26;

    _cart = [];
    _nextCartId = 1;

    _orders = [];
    _nextOrderId = 1;
  }

  // ==================== REST OF THE METHODS (keep the same) ====================
  
  Future<List<Map<String, dynamic>>> query(
    String table, {
    String? where,
    List<Object?>? whereArgs,
    String? orderBy,
    int? limit,
  }) async {
    List<Map<String, dynamic>> data;
    
    switch (table) {
      case 'users':
        data = _users;
        break;
      case 'products':
        data = _products;
        break;
      case 'cart':
        data = _cart;
        break;
      case 'orders':
        data = _orders;
        break;
      default:
        return [];
    }

    if (where != null && whereArgs != null) {
      if (where.contains('username = ?') && !where.contains('password')) {
        final username = whereArgs[0];
        data = data.where((item) => item['username'] == username).toList();
      } else if (where.contains('username = ? AND password = ?')) {
        final username = whereArgs[0];
        final password = whereArgs[1];
        data = data.where((item) => 
          item['username'] == username && item['password'] == password
        ).toList();
      } else if (where.contains('user_id = ?')) {
        final userId = whereArgs[0];
        data = data.where((item) => item['user_id'] == userId).toList();
      } else if (where.contains('id = ?')) {
        final id = whereArgs[0];
        data = data.where((item) => item['id'] == id).toList();
      } else if (where.contains('product_id = ?')) {
        final productId = whereArgs[0];
        data = data.where((item) => item['product_id'] == productId).toList();
      }
    }

    if (orderBy != null && orderBy.contains('DESC')) {
      data = List.from(data.reversed);
    }

    if (limit != null && limit > 0) {
      data = data.take(limit).toList();
    }

    return data;
  }

  Future<int> insert(String table, Map<String, dynamic> values) async {
    switch (table) {
      case 'users':
        values['id'] = _nextUserId++;
        _users.add(Map.from(values));
        return values['id'];
      case 'products':
        values['id'] = _nextProductId++;
        _products.add(Map.from(values));
        return values['id'];
      case 'cart':
        values['id'] = _nextCartId++;
        _cart.add(Map.from(values));
        return values['id'];
      case 'orders':
        values['id'] = _nextOrderId++;
        _orders.add(Map.from(values));
        return values['id'];
      default:
        return -1;
    }
  }

  Future<int> update(
    String table,
    Map<String, dynamic> values, {
    String? where,
    List<Object?>? whereArgs,
  }) async {
    List<Map<String, dynamic>> targetList;
    
    switch (table) {
      case 'cart':
        targetList = _cart;
        break;
      default:
        return 0;
    }

    int userId = -1;
    int productId = -1;
    
    if (where != null && whereArgs != null) {
      if (where.contains('user_id = ?')) {
        userId = whereArgs[0] as int;
      }
      if (where.contains('product_id = ?')) {
        productId = whereArgs[1] as int;
      }
    }

    int count = 0;
    for (var i = 0; i < targetList.length; i++) {
      if (userId != -1 && targetList[i]['user_id'] == userId && 
          productId != -1 && targetList[i]['product_id'] == productId) {
        for (var key in values.keys) {
          targetList[i][key] = values[key];
        }
        count++;
      }
    }
    
    return count;
  }

  Future<int> delete(
    String table, {
    String? where,
    List<Object?>? whereArgs,
  }) async {
    switch (table) {
      case 'users':
        if (where != null && whereArgs != null && where.contains('id = ?')) {
          final id = whereArgs[0];
          _users.removeWhere((item) => item['id'] == id);
          return 1;
        }
        break;
      case 'products':
        if (where != null && whereArgs != null && where.contains('id = ?')) {
          final id = whereArgs[0];
          _products.removeWhere((item) => item['id'] == id);
          return 1;
        }
        break;
      case 'cart':
        if (where != null && whereArgs != null) {
          if (where.contains('user_id = ? AND product_id = ?')) {
            final userId = whereArgs[0];
            final productId = whereArgs[1];
            _cart.removeWhere((item) => 
                item['user_id'] == userId && item['product_id'] == productId);
            return 1;
          } else if (where.contains('user_id = ?')) {
            final userId = whereArgs[0];
            _cart.removeWhere((item) => item['user_id'] == userId);
            return _cart.length;
          }
        }
        break;
      case 'orders':
        if (where != null && whereArgs != null && where.contains('id = ?')) {
          final id = whereArgs[0];
          _orders.removeWhere((item) => item['id'] == id);
          return 1;
        }
        break;
    }
    return 0;
  }

  Future<List<Map<String, dynamic>>> rawQuery(String sql, List<Object?> args) async {
    if (sql.contains('JOIN')) {
      final userId = args[0];
      List<Map<String, dynamic>> results = [];
      
      for (var cartItem in _cart) {
        if (cartItem['user_id'] == userId) {
          final product = _products.firstWhere(
            (p) => p['id'] == cartItem['product_id'],
            orElse: () => {},
          );
          if (product.isNotEmpty) {
            results.add({
              'quantity': cartItem['quantity'],
              ...product,
            });
          }
        }
      }
      return results;
    }
    
    return [];
  }
}
