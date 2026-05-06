// lib/models/order.dart
// Created by: Kundai Rato
// Student ID: N02423683W

class Order {
  final int id;
  final String username;
  final String address;
  final double totalAmount;
  final String paymentMethod;
  final String orderDate;

  Order({
    required this.id,
    required this.username,
    required this.address,
    required this.totalAmount,
    required this.paymentMethod,
    required this.orderDate,
  });

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      username: map['username'],
      address: map['address'],
      totalAmount: map['total_amount'].toDouble(),
      paymentMethod: map['payment_method'],
      orderDate: map['order_date'],
    );
  }
}
