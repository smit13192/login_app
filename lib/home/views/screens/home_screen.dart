import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/app/router/route_name.dart';
import 'package:login_app/login/bloc/login_bloc.dart';
import 'package:login_app/login/model/form_status.dart';
import 'package:login_app/login/model/user_status.dart';
import 'package:login_app/login/views/widgets/app_loading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.formStatus.isLoading) {
          showDialog(
            context: context,
            builder: (context) => const Loading(),
            barrierColor: Colors.transparent,
            barrierDismissible: false,
          );
        } else if (state.formStatus.isSuccess && state.userStatus.isLogOut) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteName.loginScreen,
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home page'),
        ),
        body: Center(
          child: ElevatedButton(
            child: const Text('Log Out'),
            onPressed: () {
              context.read<LoginBloc>().add(LogOutEvent());
            },
          ),
        ),
      ),
    );
  }
}
