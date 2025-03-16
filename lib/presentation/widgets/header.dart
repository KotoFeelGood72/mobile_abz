import 'package:flutter/material.dart';
import 'package:mobile_abz/app/themes/app_colors.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  const Header({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        centerTitle: true,
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.white),
                onPressed: () => Navigator.of(context).pop(),
              )
            : null,
        title: Text(
          title!,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
            overflow: TextOverflow.ellipsis, // Обрезка длинного текста
          ),
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
