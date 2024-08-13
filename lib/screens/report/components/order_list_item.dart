import 'package:flutter/material.dart';

import '../../../components/status/product_tile.dart';
import '../../../models/order_model.dart';

class OrderListItem extends StatelessWidget {
  final Orders order;

  const OrderListItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Order ID: ${order.orderId}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Product ID: ${order.productId}'),
            ProductTile(productId: order.productId),
            Text('Quantity: ${order.quantity}'),
            Text('Date: ${order.transactionDate.toLocal()}'),
          ],
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Total: \$${order.totalPrice}'),
          ],
        ),
      ),
    );
  }
}
