// lib/main.dart
// Created by: Takudzwa Murombedzi (Team Lead)
// Student ID: N02418505P

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/register_screen.dart';
import 'screens/products_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/admin/admin_dashboard.dart';
import 'screens/admin/add_product_screen.dart';
import 'screens/admin/add_users_screen.dart';
import 'services/auth_service.dart';
import 'services/database_service.dart';
import 'services/cart_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService.instance.initDB();
  runApp(const CampusStore());
}

class CampusStore extends StatelessWidget {
  const CampusStore({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => CartService()),
      ],
      child: MaterialApp(
        title: 'NUST Campus Store',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // Primary Colors
          primaryColor: const Color(0xFF17A2B8),
          scaffoldBackgroundColor: const Color(0xFFEDEDED),
          
          // Color Scheme
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF17A2B8),
            secondary: Color(0xFF1E88E5),
            tertiary: Color(0xFF0B3C5D),
            surface: Colors.white,
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onSurface: Color(0xFF0B3C5D),
          ),
          
          fontFamily: 'Roboto',
          
          // AppBar Theme
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF17A2B8),
            foregroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          // Button Theme
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E88E5),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          
          // Text Button Theme
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF1E88E5),
            ),
          ),
          
          // Outlined Button Theme
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF1E88E5),
              side: const BorderSide(color: Color(0xFF1E88E5)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          
          // Input Decoration Theme
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFD3D3D3)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFD3D3D3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF6EA8FE), width: 2),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          
          // Card Theme
          cardTheme: const CardThemeData(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            color: Colors.white,
          ),
          
          // Chip Theme
          chipTheme: ChipThemeData(
            backgroundColor: Colors.grey[200],
            selectedColor: const Color(0xFF17A2B8),
            labelStyle: const TextStyle(color: Color(0xFF0B3C5D)),
            secondaryLabelStyle: const TextStyle(color: Colors.white),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
          
          // Bottom Navigation Bar Theme
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: Color(0xFF17A2B8),
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            elevation: 8,
            backgroundColor: Colors.white,
          ),
          
          // Floating Action Button Theme
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFF1E88E5),
            foregroundColor: Colors.white,
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
          '/register': (context) => const RegisterScreen(),
          '/products': (context) => const ProductsScreen(),
          '/cart': (context) => const CartScreen(),
          '/checkout': (context) => const CheckoutScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/admin': (context) => const AdminDashboard(),
          '/add-product': (context) => const AddProductScreen(),
          '/add-users': (context) => const AddUsersScreen(),
        },
      ),
    );
  }
}