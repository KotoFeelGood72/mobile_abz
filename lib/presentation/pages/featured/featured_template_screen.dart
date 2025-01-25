import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_abz/presentation/widgets/layouts.dart';

@RoutePage()
class FeaturedTemplateScreen extends StatelessWidget {
  const FeaturedTemplateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layouts(currentIndex: 1, slivers: [
      SliverToBoxAdapter(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: const Column(
            children: [AutoRouter()],
          ),
        ),
      )
    ]);
  }
}
