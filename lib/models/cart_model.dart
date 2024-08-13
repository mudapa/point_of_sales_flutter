class CartModel {
  final String id, userId;
  final List<CartProductModel> products;

  CartModel({
    required this.id,
    required this.userId,
    required this.products,
  });

  factory CartModel.fromJson(String id, Map<String, dynamic> json) {
    return CartModel(
        id: id,
        userId: json['userId'],
        products: List<CartProductModel>.from(
            json["products"].map((x) => CartProductModel.fromJson(x))));
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'products': List<dynamic>.from(products.map((x) => x.toJson())),
    };
  }
}

class CartProductModel {
  final String productId, size;
  int quantity, price;

  CartProductModel({
    required this.productId,
    required this.size,
    required this.quantity,
    required this.price,
  });

  factory CartProductModel.fromJson(Map<String, dynamic> json) {
    return CartProductModel(
      productId: json['productId'],
      size: json['size'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'size': size,
      'quantity': quantity,
      'price': price,
    };
  }
}
