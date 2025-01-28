import 'package:flutter/material.dart';
import 'package:mobile_abz/app/themes/app_colors.dart';

class Btn extends StatelessWidget {
  const Btn({
    super.key,
    required this.onPressed,
    this.name,
    this.borderColor = const Color(0xFFDBDBDB), // По умолчанию серый
    this.textColor = AppColors.black, // По умолчанию черный
  });

  final VoidCallback onPressed;
  final String? name;
  final Color borderColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.pink,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: BorderSide(color: borderColor),
      ),
      onPressed: onPressed,
      child: Text(
        name ?? '',
        style: TextStyle(color: textColor),
      ),
    );
  }
}
