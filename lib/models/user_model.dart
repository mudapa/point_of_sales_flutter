import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String userId;
  final String? email, name;
  final int? phoneNumber, role;

  const UserModel({
    required this.userId,
    this.email,
    this.name,
    this.phoneNumber,
    this.role,
  });

  factory UserModel.fromJson(String userId, Map<String, dynamic> json) {
    return UserModel(
      userId: userId,
      email: json['email'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'role': role,
    };
  }

  @override
  List<Object?> get props => [
        userId,
        email,
        name,
        phoneNumber,
        role,
      ];
}
