import 'package:login_app/app/app_string/app_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  // user data store
  static void setUserData(String email, String username) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(AppString.email, email);
    await sharedPreferences.setString(AppString.username, username);
  }

  static Future<Map<String, String?>> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? email = sharedPreferences.getString(AppString.email);
    String? username = sharedPreferences.getString(AppString.username);
    return {
      AppString.email: email,
      AppString.username: username,
    };
  }

  // login data store
  static void setLogin(bool isLogin) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(AppString.isLogin, isLogin);
  }

  static Future<bool?> get isLogin async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? isLogin = sharedPreferences.getBool(AppString.isLogin);
    return isLogin;
  }
}
