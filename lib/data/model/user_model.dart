import 'package:flutter/foundation.dart';

class UserModel {
  int? id;
  String full_name;
  String phone_number;
  String password;

  UserModel(
      {this.id,
      required this.full_name,
      required this.phone_number,
      required this.password});

  Map<String, dynamic> toMap() {
    return {
      'full_name': full_name,
      'phone_number': phone_number,
      'password': password
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      full_name: map["FULL_NAME"],
      phone_number: map["PHONE_NUMBER"],
      password: map["PASSWORD"],
      id: map["ID"],
    );
  }
  String toString() {
    return (" $full_name, $phone_number, $password");
  }
}
