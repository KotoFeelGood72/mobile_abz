import 'package:flutter/material.dart';
import 'package:mobile_abz/app/themes/app_colors.dart';

class Btn extends StatelessWidget {
  const Btn({
    super.key,
    required this.onPressed,
    this.name,
    this.borderColor = const Color(0xFFDBDBDB), // По умолчанию серый
    this.textColor = AppColors.black, // По умолчанию черный
    this.isLoading = false, // По умолчанию false
  });

  final void Function()? onPressed;
  final String? name;
  final Color borderColor;
  final Color textColor;
  final bool isLoading;

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
      onPressed: isLoading ? null : onPressed, // Отключаем кнопку при загрузке
      child: isLoading
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.pink,
              ),
            )
          : Text(
              name ?? '',
              style: TextStyle(color: textColor),
            ),
    );
  }
}
