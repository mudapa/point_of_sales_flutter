import 'package:flutter_pos/screens/view_export.dart';

class OnboardingContent extends StatelessWidget {
  final bool isTextOnTop;
  final String title, description, image;
  const OnboardingContent({
    super.key,
    this.isTextOnTop = false,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    Widget onboardTitleDescription({
      required String title,
      required String description,
    }) {
      return Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: subtitleText,
          ),
          gapH,
          Text(
            description,
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    return Column(
      children: [
        const Spacer(),
        if (isTextOnTop)
          onboardTitleDescription(
            title: title,
            description: description,
          ),
        if (isTextOnTop) const Spacer(),
        Image.asset(
          image,
          height: 250,
        ),
        if (!isTextOnTop) const Spacer(),
        if (!isTextOnTop)
          onboardTitleDescription(
            title: "Jelajahi dunia belanja yang tak terbatas!",
            description:
                "Dengan beragam produk yang tersedia, kamu pasti akan menemukan apa yang kamu cari.",
          ),
        const Spacer(),
      ],
    );
  }
}
