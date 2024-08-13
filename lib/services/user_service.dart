import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';
import '../shared/helper.dart';

class UserService {
  Future<void> setUser(UserModel user) async {
    try {
      userRef.doc(user.userId).set({
        'userId': user.userId,
        'email': user.email,
        'name': user.name,
        'phoneNumber': user.phoneNumber,
        'role': user.role,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getUserById(String id) async {
    try {
      await settings.put('id', id);

      DocumentSnapshot user = await userRef.doc(id).get();

      return UserModel(
        userId: user.id,
        email: user['email'],
        name: user['name'],
        phoneNumber: user['phoneNumber'],
        role: user['role'],
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> updateUser({
    required String id,
    required String name,
    required int phoneNumber,
    required String email,
  }) async {
    try {
      await userRef.doc(id).update({
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'role': 1,
      });

      return UserModel(
        userId: id,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        role: 1,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserModel>> fetchUsers() async {
    try {
      QuerySnapshot result = await userRef.get();

      List<UserModel> users = result.docs.map(
        (e) {
          return UserModel.fromJson(e.id, e.data() as Map<String, dynamic>);
        },
      ).toList();

      return users;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> deleteUser(String id) async {
    try {
      await userRef.doc(id).delete();

      return UserModel(userId: id);
    } catch (e) {
      rethrow;
    }
  }
}
