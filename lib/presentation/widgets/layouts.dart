import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile_abz/app/themes/app_colors.dart';
import 'package:mobile_abz/presentation/widgets/header.dart';
import 'package:mobile_abz/presentation/widgets/ui/bottom_bar.dart';

class Layouts extends StatelessWidget {
  final Widget? sliverAppBar;
  final List<Widget> slivers;
  final Widget? floatingActionButton;
  final int currentIndex;
  final bool isLoading; // Добавлено поле для управления loader'ом

  const Layouts({
    super.key,
    required this.slivers,
    this.sliverAppBar,
    this.floatingActionButton,
    required this.currentIndex,
    this.isLoading = false, // По умолчанию false, если явно не передано true
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        top: true,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(color: AppColors.white),
              child: CustomScrollView(
                slivers: [
                  if (sliverAppBar != null) sliverAppBar!,
                  SliverPersistentHeader(
                    pinned: false,
                    floating: false,
                    delegate: _FixedHeaderDelegate(
                      child: const Header(),
                    ),
                  ),
                  ...slivers,
                ],
              ),
            ),

            // Loader на весь экран, если идет загрузка
            if (isLoading) _buildLoader(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
      ),
    );
  }

  Widget _buildLoader() {
    return Positioned.fill(
      child: Stack(
        children: [
          // Размытие фона
          BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 5.0, sigmaY: 5.0), // Интенсивность blur
            child: Container(
              color: AppColors.white, // Полупрозрачный фон
            ),
          ),
          Center(
            child: SizedBox(
              width: 60,
              height: 60,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Логотип в центре
                  Image.asset(
                    'assets/images/logo.png',
                    width: 70,
                    height: 70,
                  ),
                  // Крутящийся индикатор
                  Positioned.fill(
                    child: Center(
                      child: SizedBox(
                        width: 80, // Размер спиннера
                        height: 80,
                        child: CircularProgressIndicator(
                          strokeWidth: 4,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(AppColors.pink),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Делегат для SliverPersistentHeader
class _FixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _FixedHeaderDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 60;
  @override
  double get minExtent => 60;
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
