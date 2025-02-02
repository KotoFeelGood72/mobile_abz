import 'package:flutter/material.dart';
import 'package:mobile_abz/app/themes/app_colors.dart';
import 'package:mobile_abz/presentation/widgets/header.dart';
import 'package:mobile_abz/presentation/widgets/ui/bottom_bar.dart';

class Layouts extends StatelessWidget {
  final Widget? sliverAppBar;
  final List<Widget> slivers;
  final Widget? floatingActionButton;
  final int currentIndex; // Добавлено поле для передачи текущего индекса

  const Layouts({
    super.key,
    required this.slivers,
    this.sliverAppBar,
    this.floatingActionButton,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
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
  double get maxExtent => 60; // Высота Header
  @override
  double get minExtent => 60; // Высота Header
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
