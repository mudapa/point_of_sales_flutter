import '../component_export.dart';

class PaymentMethodCard extends StatelessWidget {
  final String image, title;
  final VoidCallback press;
  const PaymentMethodCard({
    super.key,
    required this.image,
    required this.title,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: whiteColor,
          border: Border.all(color: greyColor.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(defaultBorderRadious),
        ),
        height: 155,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Center(
                child: Stack(
                  children: [
                    // NetworkImageWithLoader(
                    //   image,
                    //   radius: defaultBorderRadious,
                    // ),
                    Image.asset(
                      image,
                      fit: BoxFit.cover,
                      width: 64,
                      height: 64,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: defaultPadding),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: titleText.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
