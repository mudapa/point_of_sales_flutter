import '../view_export.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, onboardingPageRoute);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Fin Shop',
              style: displayText.copyWith(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: primaryColor,
                letterSpacing: 2,
              ),
              textAlign: TextAlign.center,
            ),
            gapH,
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: primaryColor,
                  width: 2,
                ),
              ),
              child: lottieSplash,
            ),
          ],
        ),
      ),
    );
  }
}
