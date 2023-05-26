import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?) validator;
  final bool obscureText;
  final Widget? suffixIcon;

  const AppTextFormField({
    required this.controller,
    required this.hintText,
    required this.validator,
    this.obscureText = false,
    this.suffixIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        hintText: hintText,
        suffixIcon: suffixIcon,
      ),
      validator: validator,
    );
  }
}
