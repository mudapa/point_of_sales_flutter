import '../view_export.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late PageController _pageController;
  int _pageIndex = 0;
  final List<Onboard> _onboardData = [
    Onboard(
      image: "assets/illustration/Illustration-0.png",
      imageDarkTheme: "assets/illustration/Illustration_darkTheme_0.png",
      title: "Jelajahi dunia belanja yang tak terbatas!",
      description:
          "Dengan beragam produk yang tersedia, kamu pasti akan menemukan apa yang kamu cari.",
    ),
    Onboard(
      image: "assets/illustration/Illustration-1.png",
      imageDarkTheme: "assets/illustration/Illustration_darkTheme_1.png",
      title: "Kumpulkan semua barang impianmu!",
      description:
          "Tambahkan ke keranjang atau simpan di daftar keinginan untuk dibeli nanti.",
    ),
    Onboard(
      image: "assets/illustration/Illustration-2.png",
      imageDarkTheme: "assets/illustration/Illustration_darkTheme_2.png",
      title: "Transaksi aman, belanja puas!",
      description: "Nikmati berbagai pilihan pembayaran yang aman dan mudah.",
    ),
    Onboard(
      image: "assets/illustration/Illustration-3.png",
      imageDarkTheme: "assets/illustration/Illustration_darkTheme_3.png",
      title: "Paketmu selalu terpantau!",
      description: "Fin Shop akan memastikan paketmu sampai dengan selamat.",
    ),
    Onboard(
      image: "assets/illustration/Illustration-4.png",
      imageDarkTheme: "assets/illustration/Illustration_darkTheme_4.png",
      title: "Toko terdekat, belanja terdekat!",
      description: "Temukan toko terdekat dan nikmati kemudahan berbelanja.",
    ),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, loginPageRoute);
                  },
                  child: Text(
                    "Skip",
                    style: bodyText,
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _onboardData.length,
                  onPageChanged: (value) {
                    setState(() {
                      _pageIndex = value;
                    });
                  },
                  itemBuilder: (context, index) => OnboardingContent(
                    title: _onboardData[index].title,
                    description: _onboardData[index].description,
                    image: (Theme.of(context).brightness == Brightness.dark &&
                            _onboardData[index].imageDarkTheme != null)
                        ? _onboardData[index].imageDarkTheme!
                        : _onboardData[index].image,
                    isTextOnTop: index.isOdd,
                  ),
                ),
              ),
              Row(
                children: [
                  ...List.generate(
                    _onboardData.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: defaultPadding / 4),
                      child: DotIndicator(isActive: index == _pageIndex),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_pageIndex < _onboardData.length - 1) {
                          _pageController.nextPage(
                              curve: Curves.ease, duration: defaultDuration);
                        } else {
                          Navigator.pushNamed(context, loginPageRoute);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/Arrow - Right.svg",
                        colorFilter: const ColorFilter.mode(
                          whiteColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              gapH,
            ],
          ),
        ),
      ),
    );
  }
}
