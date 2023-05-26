import 'package:flutter/material.dart';

@immutable
class UserModel {
  final String username;
  final String email;
  final String? imageUrl;

  const UserModel({required this.username, required this.email, this.imageUrl});

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'imageUrl': imageUrl,
      };
}
