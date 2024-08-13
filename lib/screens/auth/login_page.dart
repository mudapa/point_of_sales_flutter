import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/auth_cubit/auth_cubit.dart';
import '../view_export.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLogin = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/images/logo.png",
                height: 200,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Selamat datang!",
                      style: bodyText.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Fin Shop akan memastikan paketmu sampai dengan selamat.",
                    ),
                    gapH,
                    LoginForm(
                      formKey: _formKey,
                      isLogin: isLogin,
                      emailController: emailController,
                      passwordController: passwordController,
                      nameController: nameController,
                      phoneController: phoneController,
                    ),
                    if (isLogin)
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          child: const Text("Lupa password?"),
                          onPressed: () {
                            // Navigator.pushNamed(
                            //     context, passwordRecoveryScreenRoute);
                          },
                        ),
                      ),
                    gapH,
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthSuccess) {
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              entryPointPageRoute,
                              ModalRoute.withName(loginPageRoute));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: successColor,
                              content: Text(
                                  "Selamat datang, ${state.user.name}",
                                  style: bodyText.copyWith(color: whiteColor)),
                            ),
                          );
                        }

                        if (state is RegisterSuccess) {
                          setState(() {
                            isLogin = true;
                            emailController.clear();
                            passwordController.clear();
                            nameController.clear();
                            phoneController.clear();
                          });
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.all(defaultPadding),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("Registrasi berhasil",
                                            style: bodyText),
                                        gapH,
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: successColor,
                                            minimumSize: const Size(80, 50),
                                            maximumSize: const Size(80, 50),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Close"),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }

                        if (state is AuthFailure) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.all(defaultPadding),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(state.message,
                                            style: bodyText.copyWith(
                                                color: errorColor)),
                                        gapH,
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: errorColor,
                                            minimumSize: const Size(80, 50),
                                            maximumSize: const Size(80, 50),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Close"),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        return ElevatedButton(
                          onPressed: () {
                            if (isLogin) {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthCubit>().signIn(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                              }
                            }

                            if (!isLogin) {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthCubit>().signUp(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phoneNumber:
                                          int.parse(phoneController.text),
                                    );
                              }
                            }
                          },
                          child: Text(isLogin ? "Masuk" : "Daftar"),
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(isLogin
                            ? "Belum punya akun?"
                            : "Sudah punya akun?"),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isLogin = !isLogin;
                              emailController.clear();
                              passwordController.clear();
                              nameController.clear();
                              phoneController.clear();
                            });
                          },
                          child: Text(isLogin ? "Daftar" : "Masuk"),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
