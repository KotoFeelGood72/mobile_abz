import 'package:flutter/material.dart';
import 'package:mobile_abz/app/themes/app_colors.dart';

class Btn extends StatelessWidget {
  const Btn({super.key, required this.onPressed, this.name});
  final VoidCallback onPressed;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.pink,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          side: const BorderSide(color: Color(0xFFDBDBDB)),
        ),
        onPressed: onPressed,
        child:
            Text(name ?? '', style: const TextStyle(color: AppColors.black)));
  }
}
