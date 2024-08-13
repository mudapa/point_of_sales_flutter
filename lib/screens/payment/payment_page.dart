import '../view_export.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Payment",
          style: titleText,
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding / 2),
              child: Text(
                "Choose Payment Method",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: demoPaymentMethod.length,
                itemBuilder: (context, index) => ExpansionPayment(
                  imgSrc: demoPaymentMethod[index].image!,
                  name: demoPaymentMethod[index].name!,
                  subCategory: demoPaymentMethod[index].subCategories!,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
