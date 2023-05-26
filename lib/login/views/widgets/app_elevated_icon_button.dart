import 'package:flutter/material.dart';

class AppElevatedIconButton extends StatelessWidget {
  final Widget icon;
  final String text;
  final Color buttonColor;
  final void Function() onTap;

  const AppElevatedIconButton({
    required this.icon,
    required this.text,
    required this.buttonColor,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
            )
          ],
        ),
      ),
    );
  }
}
