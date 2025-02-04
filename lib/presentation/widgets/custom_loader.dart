import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:mobile_abz/app/themes/app_colors.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Затемненный фон
        Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.7)),
        ),
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Логотип
              Image.asset(
                'assets/images/loader.png',
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 200),

              // Новый лоадер из `loading_animation_widget`
              LoadingAnimationWidget.staggeredDotsWave(
                color: AppColors.pink, // Цвет анимации
                size: 60, // Размер анимации
              ),
            ],
          ),
        ),
      ],
    );
  }
}
