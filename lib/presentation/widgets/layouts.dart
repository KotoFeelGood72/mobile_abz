import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile_abz/app/themes/app_colors.dart';
import 'package:mobile_abz/presentation/widgets/custom_loader.dart';
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
      body: Stack(
        children: [
          // Основной контент
          SafeArea(
            bottom: true,
            top: true,
            child: Container(
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
          ),

          if (isLoading)
            Positioned.fill(
              child: AbsorbPointer(
                absorbing: true, // Блокирует взаимодействие под лоадером
                child: Container(
                  color: AppColors.black,
                  child: const CustomLoader(),
                ),
              ),
            ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: isLoading ? null : floatingActionButton,
      bottomNavigationBar: isLoading
          ? null // Убираем нижний бар, когда лоадер активен
          : CustomBottomNavBar(currentIndex: currentIndex),
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
