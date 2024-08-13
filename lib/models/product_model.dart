import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String productId, brandName, title;
  final String? image;
  final int price;
  final int? stock, dicountpercent, priceAfetDiscount;

  const ProductModel({
    required this.productId,
    this.image,
    required this.brandName,
    required this.title,
    required this.price,
    this.priceAfetDiscount,
    this.dicountpercent,
    this.stock,
  });

  factory ProductModel.fromJson(String productId, Map<String, dynamic> json) {
    return ProductModel(
      productId: productId,
      image: json['image'],
      brandName: json['brandName'],
      title: json['title'],
      price: json['price'],
      priceAfetDiscount: json['priceAfetDiscount'],
      dicountpercent: json['dicountpercent'],
      stock: json['stock'],
    );
  }

  @override
  List<Object?> get props => [
        productId,
        image,
        brandName,
        title,
        price,
        priceAfetDiscount,
        dicountpercent,
        stock,
      ];
}
