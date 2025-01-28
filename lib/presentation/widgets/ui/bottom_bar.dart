import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:mobile_abz/app/router/app_router.gr.dart';
import 'package:mobile_abz/app/themes/app_colors.dart';
import 'package:mobile_abz/presentation/widgets/Icons.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Widget? floatingButton; // Добавлено поле для кнопки

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    this.floatingButton, // Опциональный параметр для плавающей кнопки
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tabs = [
      {
        'icon': 'home-restangle',
        'activeIcon': 'home',
        'label': 'Главная',
        'route': const HomeRoute(),
      },
      {
        'icon': 'car-restangle',
        'activeIcon': 'car',
        'label': 'Авто',
        'route': const FeaturedRoute(),
      },
      {
        'icon': 'faq-restangle',
        'activeIcon': 'faq',
        'label': 'Помощь',
        'route': const FaqRoute(),
      },
      {
        'icon': 'contacts-restangle',
        'activeIcon': 'contacts',
        'label': 'Контакты',
        'route': const ContactsRoute(),
      },
      {
        'icon': 'assets/images/nav.png',
        'label': 'Навигация',
        'route': null,
      },
    ];

    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          height: 69,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: tabs.asMap().entries.map((entry) {
                final index = entry.key;
                final tab = entry.value;
                final isActive = currentIndex == index;

                return GestureDetector(
                  onTap: () async {
                    if (index == tabs.length - 1) {
                      const url = 'https://yandex.ru/maps/';
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      } else {
                        throw 'Не удалось открыть $url';
                      }
                    } else {
                      final route = tab['route'] as PageRouteInfo?;
                      if (route != null &&
                          context.router.current.name != route.routeName) {
                        context.router.replace(route);
                      }
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isActive && index != tabs.length - 1
                          ? AppColors.white.withOpacity(0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        if (index == tabs.length - 1)
                          Image.asset(
                            tab['icon'],
                            width: 22,
                            height: 22,
                          )
                        else
                          IconWidget(
                            iconName:
                                isActive ? tab['activeIcon'] : tab['icon'],
                            color: isActive ? AppColors.white : AppColors.light,
                            size: 22,
                          ),
                        if (isActive && index != tabs.length - 1)
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(
                              tab['label'] as String,
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
