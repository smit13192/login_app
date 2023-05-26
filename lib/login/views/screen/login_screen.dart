import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_app/app/app_color/app_color.dart';
import 'package:login_app/app/app_string/app_string.dart';
import 'package:login_app/app/router/route_name.dart';
import 'package:login_app/login/bloc/login_bloc.dart';
import 'package:login_app/login/model/user_status.dart';
import 'package:login_app/login/views/widgets/app_elevated_button.dart';
import 'package:login_app/login/views/widgets/app_elevated_icon_button.dart';
import 'package:login_app/login/views/widgets/app_loading.dart';
import 'package:login_app/login/views/widgets/app_textformfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool obscureText = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.userStatus.isLoading) {
            showDialog(
              context: context,
              builder: (context) => const Loading(),
              barrierColor: Colors.transparent,
              barrierDismissible: false,
            );
          } else if (state.userStatus.isSuccess) {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, RouteName.homeScreen);
          } else if (state.userStatus.isFailed) {
            Navigator.pop(context);
            Fluttertoast.showToast(msg: state.error!);
          }
        },
        child: SafeArea(
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (notification) {
              notification.disallowIndicator();
              return true;
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(AppString.loginImage),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Form(
                      key: _key,
                      child: Column(
                        children: [
                          AppTextFormField(
                            controller: _usernameController,
                            hintText: 'Username',
                            suffixIcon: IconButton(
                              onPressed: () => _usernameController.clear(),
                              icon: const Icon(Icons.clear),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Enter valid username';
                              }
                              if (value.contains(' ')) {
                                return 'Username not contain space';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          AppTextFormField(
                            controller: _emailController,
                            hintText: 'Email',
                            suffixIcon: IconButton(
                              onPressed: () => _emailController.clear(),
                              icon: const Icon(Icons.clear),
                            ),
                            validator: (value) {
                              if (!EmailValidator.validate(value!.trim())) {
                                return 'Enter valid email id';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          AppTextFormField(
                            controller: _passwordController,
                            hintText: 'Password',
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                              icon: obscureText
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                            ),
                            obscureText: obscureText,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Enter valid password';
                              }
                              if (value.contains(' ')) {
                                return 'Password not contain space';
                              }
                              if (value.length < 8) {
                                return 'Password length should be 8 letters';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          AppElevatedButton(
                            onTap: () {
                              if (_key.currentState!.validate()) {
                                context.read<LoginBloc>().add(EmailLoginEvent(
                                      username: _usernameController.text,
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    ));
                              }
                            },
                            text: AppString.login,
                          ),
                          const SizedBox(height: 15),
                          const Row(
                            children: [
                              Expanded(child: Divider(thickness: 2)),
                              Text(' OR '),
                              Expanded(child: Divider(thickness: 2)),
                            ],
                          ),
                          const SizedBox(height: 15),
                          AppElevatedIconButton(
                            icon: const FaIcon(
                              FontAwesomeIcons.google,
                              color: Colors.white,
                            ),
                            text: AppString.sighInGoogle,
                            buttonColor: AppColor.googleColor,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
