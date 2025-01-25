import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_abz/presentation/widgets/featured_card.dart';

@RoutePage()
class FeaturedScreen extends StatelessWidget {
  const FeaturedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Рекомендации'),
        Column(
          children: [FeaturedCard(title: 'title', image: '', id: '1')],
        ),
      ],
    );
  }
}
