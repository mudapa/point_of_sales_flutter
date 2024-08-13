import 'package:cloud_firestore/cloud_firestore.dart';

import '../../shared/helper.dart';
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
      authCubit(context).getCurrentUser();

      if (auth.currentUser == null) {
        Navigator.pushReplacementNamed(context, onboardingPageRoute);
      } else {
        FirebaseFirestore.instance
            .collection('users')
            .doc(auth.currentUser!.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            Map<String, dynamic> userData =
                documentSnapshot.data() as Map<String, dynamic>;
            int? role = userData['role'];

            if (role == 1) {
              Navigator.pushNamedAndRemoveUntil(context, entryPointPageRoute,
                  ModalRoute.withName(loginPageRoute));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: successColor,
                  content: Text("Selamat datang kembali, ${userData['name']}",
                      style: bodyText.copyWith(color: whiteColor)),
                ),
              );
            }
          }
        }).catchError((error) {});
      }
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
