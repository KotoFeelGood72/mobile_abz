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
      backgroundColor: AppColors.black,
      body: SafeArea(
        bottom: true,
        top: true,
        child: CustomScrollView(
          slivers: [
            if (sliverAppBar != null) sliverAppBar!,
            const SliverToBoxAdapter(
              child: Header(),
            ),
            ...slivers,
          ],
        ),
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex, // Передаем текущий индекс
      ),
    );
  }
}
