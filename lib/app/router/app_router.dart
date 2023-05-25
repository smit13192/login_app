import 'package:flutter/cupertino.dart';
import 'package:login_app/app/router/router_name.dart';
import 'package:login_app/login/views/screen/login_screen.dart';
import 'package:login_app/splash/views/screen/splash_screen.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    String routeName = settings.name!;
    switch (routeName) {
      case RouteName.splashScreen:
        return CupertinoPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case RouteName.loginScreen:
        return CupertinoPageRoute(
          builder: (_) => const LoginScreen(),
        );
      default:
        return null;
    }
  }
}
