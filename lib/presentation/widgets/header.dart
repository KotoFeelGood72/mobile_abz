import 'package:flutter/material.dart';
import 'package:mobile_abz/app/themes/app_colors.dart';
import 'package:mobile_abz/presentation/widgets/form_bottom_sheet.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: AppColors.black,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  child: Image.asset('assets/images/logo.png'),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'АвтоБезЗабот',
                  style: TextStyle(fontSize: 18, color: AppColors.white),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () => FormBottomSheet.show(
              context: context,
              title: 'Свяжитесь с нами',
              subtitle:
                  'Заполните форму, и мы свяжемся с вами в ближайшее время.',
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: AppColors.pink)),
              child: const Text(
                'Консультация',
                style: TextStyle(fontSize: 14, color: AppColors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
