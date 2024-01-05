
import 'dart:convert';

UserModel usersFromJson(String str) => UserModel.fromJson(json.decode(str));

String usersToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? email;
  String? fullname;

  UserModel({
    this.email, 
    this.fullname,
  });

  // receiving data from server
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      fullname: json['fullname']
    );
  }

  // sending data to our server
  Map<String, dynamic> toJson() => {
      'email': email,
      'fullname': fullname,
    };
  }
