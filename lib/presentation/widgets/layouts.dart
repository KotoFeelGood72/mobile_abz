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
  final String? title; // Добавлено поле для заголовка

  const Layouts({
    super.key,
    required this.slivers,
    this.sliverAppBar,
    this.title,
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
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )),
              child: CustomScrollView(
                physics: ClampingScrollPhysics(),
                slivers: [
                  if (sliverAppBar != null) sliverAppBar!,
                  SliverPersistentHeader(
                    pinned: false,
                    floating: false,
                    delegate: _FixedHeaderDelegate(
                      child: Header(
                        title: title,
                      ),
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
                absorbing: true,
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
