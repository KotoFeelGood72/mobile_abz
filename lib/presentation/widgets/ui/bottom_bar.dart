import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:mobile_abz/app/router/app_router.gr.dart';
import 'package:mobile_abz/app/themes/app_colors.dart';
import 'package:mobile_abz/presentation/widgets/Icons.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
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
        'label': 'Сетка',
        'route': const ContactsRoute(),
      },
      {
        'icon': 'assets/images/nav.png',
        'label': 'Навигация',
        'route': null,
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.black,
        border: const Border(
          top: BorderSide(
            color: AppColors.pink,
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.pink.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, -2), // Тень сверху
          ),
        ],
      ),
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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                      width: 24,
                      height: 24,
                    )
                  else
                    IconWidget(
                      iconName: isActive ? tab['activeIcon'] : tab['icon'],
                      color: isActive ? AppColors.white : AppColors.light,
                      size: 24,
                    ),
                  if (isActive && index != tabs.length - 1)
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
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
    );
  }
}
