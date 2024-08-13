class PaymentMethodModel {
  final String? name, image;
  final List<PaymentMethodModel>? subCategories;

  PaymentMethodModel({
    this.name,
    this.image,
    this.subCategories,
  });
}

final List<PaymentMethodModel> demoPaymentMethod = [
  PaymentMethodModel(
    name: "Bank",
    image: "assets/icons/card.svg",
    subCategories: [
      PaymentMethodModel(name: "BCA"),
      PaymentMethodModel(name: "BNI"),
      PaymentMethodModel(name: "BRI"),
      PaymentMethodModel(name: "Mandiri"),
      PaymentMethodModel(name: "CIMB Niaga"),
      PaymentMethodModel(name: "Maybank"),
    ],
  ),
  PaymentMethodModel(
    name: "E-Wallet",
    image: "assets/icons/mobile-payment.svg",
    subCategories: [
      PaymentMethodModel(name: "OVO"),
      PaymentMethodModel(name: "GOPAY"),
      PaymentMethodModel(name: "DANA"),
      PaymentMethodModel(name: "LinkAja"),
      PaymentMethodModel(name: "ShopeePay"),
    ],
  ),
  PaymentMethodModel(
    name: "Cash",
    image: "assets/icons/Cash.svg",
    subCategories: [
      PaymentMethodModel(name: "Cash on Delivery"),
    ],
  ),
];
