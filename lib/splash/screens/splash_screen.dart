import 'dart:async';

import 'package:flutter/material.dart';
import 'package:login_app/app/app_color/app_color.dart';
import 'package:login_app/app/app_string/app_string.dart';
import 'package:login_app/app/router/route_name.dart';
import 'package:login_app/app/storage/app_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    initLoad();
    super.initState();
  }

  initLoad() {
    Timer(const Duration(seconds: 2), () {
      AppStorage.isLogin.then((isLogin) {
        if (isLogin == null || isLogin == false) {
          Navigator.pushReplacementNamed(context, RouteName.loginScreen);
        } else if (isLogin == true) {
          Navigator.pushReplacementNamed(context, RouteName.homeScreen);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            AppString.appName,
            style: TextStyle(
              fontSize: 50,
              color: AppColor.appColor,
            ),
          ),
          Image.asset(AppString.splashImage)
        ],
      ),
    );
  }
}
