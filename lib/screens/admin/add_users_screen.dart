// lib/screens/admin/add_users_screen.dart
// Created by: Tinoidaishe Mwenga
// Student ID: N02422373H

import 'package:flutter/material.dart';
import '../../services/database_service.dart';

class AddUsersScreen extends StatefulWidget {
  const AddUsersScreen({super.key});

  @override
  State<AddUsersScreen> createState() => _AddUsersScreenState();
}

class _AddUsersScreenState extends State<AddUsersScreen> {
  bool _isLoading = false;
  String _message = '';

  final List<Map<String, String>> _users = [
    {'username': 'takudzwa', 'password': 'N02418505P', 'role': 'student'},
    {'username': 'kups1234', 'password': 'N0245678K', 'role': 'student'},
    {'username': 'denzeljoe', 'password': 'N0249876H', 'role': 'student'},
    {'username': 'tinashem', 'password': 'N0241111A', 'role': 'student'},
    {'username': 'ruvimbai', 'password': 'N0242222B', 'role': 'student'},
    {'username': 'panashe', 'password': 'N0243333C', 'role': 'student'},
    {'username': 'tapiwa', 'password': 'N0244444D', 'role': 'student'},
    {'username': 'kudzai', 'password': 'N0245555E', 'role': 'student'},
    {'username': 'tawanda', 'password': 'N0246666F', 'role': 'student'},
    {'username': 'nyasha', 'password': 'N0247777G', 'role': 'student'},
    {'username': 'john_m', 'password': 'NUST2024001', 'role': 'student'},
    {'username': 'sarah_k', 'password': 'NUST2024002', 'role': 'student'},
    {'username': 'mike_t', 'password': 'NUST2024003', 'role': 'student'},
    {'username': 'lisa_w', 'password': 'NUST2024004', 'role': 'student'},
    {'username': 'david_z', 'password': 'NUST2024005', 'role': 'student'},
    {'username': 'anna_b', 'password': 'NUST2024006', 'role': 'student'},
    {'username': 'peter_m', 'password': 'NUST2024007', 'role': 'student'},
    {'username': 'grace_c', 'password': 'NUST2024008', 'role': 'student'},
    {'username': 'james_l', 'password': 'NUST2024009', 'role': 'student'},
    {'username': 'faith_r', 'password': 'NUST2024010', 'role': 'student'},
    {'username': 'elton_j', 'password': 'NUST2024011', 'role': 'student'},
    {'username': 'prisca_t', 'password': 'NUST2024012', 'role': 'student'},
    {'username': 'brian_g', 'password': 'NUST2024013', 'role': 'student'},
    {'username': 'sheila_k', 'password': 'NUST2024014', 'role': 'student'},
    {'username': 'clinton_m', 'password': 'NUST2024015', 'role': 'student'},
    {'username': 'tariro_s', 'password': 'NUST2024016', 'role': 'student'},
    {'username': 'anotidaishe', 'password': 'NUST2024017', 'role': 'student'},
    {'username': 'ruramai', 'password': 'NUST2024018', 'role': 'student'},
    {'username': 'tendai', 'password': 'NUST2024019', 'role': 'student'},
    {'username': 'chiedza', 'password': 'NUST2024020', 'role': 'student'},
  ];

  Future<void> _addAllUsers() async {
    setState(() {
      _isLoading = true;
      _message = '';
    });

    final dbService = DatabaseService.instance;
    int successCount = 0;
    int failCount = 0;

    for (var user in _users) {
      try {
        await dbService.insert('users', {
          'username': user['username'],
          'password': user['password'],
          'role': user['role'],
        });
        successCount++;
      } catch (e) {
        failCount++;
      }
    }

    setState(() {
      _isLoading = false;
      _message = '✅ $successCount users added successfully!\n❌ $failCount failed (may already exist)';
    });
  }

  Future<void> _viewAllUsers() async {
    final dbService = DatabaseService.instance;
    final users = await dbService.query('users');
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('All Users', style: TextStyle(color: Color(0xFF0B3C5D))),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                leading: Icon(
                  user['role'] == 'admin' ? Icons.admin_panel_settings : Icons.person,
                  color: user['role'] == 'admin' ? Colors.red : const Color(0xFF17A2B8),
                ),
                title: Text(user['username'], style: const TextStyle(color: Color(0xFF0B3C5D))),
                subtitle: Text('Role: ${user['role']}'),
                trailing: Text('ID: ${user['id']}'),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      appBar: AppBar(
        title: const Text('User Management'),
        backgroundColor: const Color(0xFF17A2B8),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Icon(Icons.people, size: 64, color: Color(0xFF17A2B8)),
                    const SizedBox(height: 16),
                    const Text(
                      'Add 30 Users',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0B3C5D),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This will add ${_users.length} student accounts',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _isLoading ? null : _addAllUsers,
                            icon: const Icon(Icons.person_add),
                            label: const Text('Add All Users'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1E88E5),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _viewAllUsers,
                            icon: const Icon(Icons.list),
                            label: const Text('View Users'),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFF17A2B8)),
                              foregroundColor: const Color(0xFF17A2B8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (_isLoading)
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      ),
                    if (_message.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          _message,
                          style: const TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sample Login Credentials:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0B3C5D),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Student Login:', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Username: takudzwa', style: const TextStyle(fontFamily: 'monospace')),
                          Text('Password: N02418505P', style: const TextStyle(fontFamily: 'monospace')),
                          const SizedBox(height: 8),
                          const Text('Admin Login:', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Username: admin', style: const TextStyle(fontFamily: 'monospace')),
                          Text('Password: 1234', style: const TextStyle(fontFamily: 'monospace')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
