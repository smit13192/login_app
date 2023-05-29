import 'dart:convert';

import 'package:login_app/app/app_string/app_string.dart';
import 'package:login_app/login/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  // user data store
  static Future<void> setUserData(UserModel user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(
        AppString.appUser, jsonEncode(user.toJson()));
  }

  static Future<Map<String, dynamic>> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? user = sharedPreferences.getString(AppString.appUser);
    return jsonDecode(user ?? '');
  }

  // login data store
  static Future<void> setLogin(bool isLogin) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(AppString.isLogin, isLogin);
  }

  static Future<bool?> get isLogin async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? isLogin = sharedPreferences.getBool(AppString.isLogin);
    return isLogin;
  }

  static Future<void> clearData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}
