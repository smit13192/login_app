import 'package:flutter/material.dart';
import 'package:login_app/app/router/app_router.dart';
import 'package:login_app/app/router/router_name.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.purple),
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: RouteName.splashScreen,
    );
  }
}
