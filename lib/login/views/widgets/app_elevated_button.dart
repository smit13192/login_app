import 'package:flutter/material.dart';
import 'package:login_app/app/app_color/app_color.dart';

class AppElevatedButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  const AppElevatedButton({required this.onTap, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: AppColor.appColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}
