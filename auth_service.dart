// lib/services/auth_service.dart
// Created by: Kundai Rato
// Student ID: N02423683W

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'database_service.dart';

class AuthService extends ChangeNotifier {
  String? _currentUser;
  String? _currentRole;
  bool _isLoggedIn = false;

  String? get currentUser => _currentUser;
  String? get currentRole => _currentRole;
  bool get isLoggedIn => _isLoggedIn;
  bool get isAdmin => _currentRole == 'admin';

  Future<bool> register(String username, String password, String role) async {
    try {
      final dbService = DatabaseService.instance;
      await dbService.insert('users', {
        'username': username,
        'password': password,
        'role': role,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> login(String username, String password) async {
    final dbService = DatabaseService.instance;
    final result = await dbService.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    
    if (result.isNotEmpty) {
      _currentUser = username;
      _currentRole = result.first['role'] as String;
      _isLoggedIn = true;
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);
      await prefs.setString('role', _currentRole!);
      
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    _currentUser = null;
    _currentRole = null;
    _isLoggedIn = false;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    
    notifyListeners();
  }

  Future<void> checkAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final role = prefs.getString('role');
    
    if (username != null && role != null) {
      _currentUser = username;
      _currentRole = role;
      _isLoggedIn = true;
      notifyListeners();
    }
  }
}
