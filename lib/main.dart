import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/app/app_color/material_color.dart';
import 'package:login_app/app/router/app_router.dart';
import 'package:login_app/app/router/route_name.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: AppMaterialColor.primary),
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: RouteName.splashScreen,
    );
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    log("change in $bloc: $change");
    super.onChange(bloc, change);
  }
}
