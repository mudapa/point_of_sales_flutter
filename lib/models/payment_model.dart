import 'package:flutter_pos/models/order_model.dart';

class Payment {
  final String paymentId;
  final String status;
  final Orders order;

  Payment({
    required this.paymentId,
    required this.status,
    required this.order,
  });

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      paymentId: map['paymentId'],
      status: map['status'],
      order: Orders.fromMap(map['order']),
    );
  }
}
