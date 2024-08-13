import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';
import '../shared/helper.dart';
import 'user_service.dart';

class AuthService {
  Future<UserModel> getUserById() async {
    try {
      final String? uid = await settings.get('id');

      UserModel user = await UserService().getUserById(uid!);

      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> signUp({
    required String email,
    required String password,
    required String name,
    required int phoneNumber,
  }) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel user = UserModel(
        userId: userCredential.user!.uid,
        email: email,
        name: name,
        phoneNumber: phoneNumber,
        role: 1,
      );

      await UserService().setUser(user);

      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel user =
          await UserService().getUserById(userCredential.user!.uid);

      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await settings.delete('id');

      await auth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
