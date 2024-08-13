class Orders {
  final String orderId;
  final String productId;
  final int quantity;
  final int pricePerItem;
  final int totalPrice;
  final String paymentMethod;
  final DateTime transactionDate;

  Orders({
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.pricePerItem,
    required this.totalPrice,
    required this.paymentMethod,
    required this.transactionDate,
  });

  factory Orders.fromMap(Map<String, dynamic> map) {
    return Orders(
      orderId: map['orderId'],
      productId: map['productId'],
      quantity: map['quantity'],
      pricePerItem: map['pricePerItem'],
      totalPrice: map['totalPrice'],
      paymentMethod: map['paymentMethod'],
      transactionDate: map['transactionDate'].toDate(),
    );
  }
}
