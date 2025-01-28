import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mobile_abz/app/router/app_router.gr.dart';
import 'package:mobile_abz/presentation/widgets/featured_card.dart';
import 'package:mobile_abz/presentation/widgets/layouts.dart';

@RoutePage()
@RoutePage()
class FeaturedScreen extends StatelessWidget {
  const FeaturedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> recommendations = [
      {
        'title': 'Как подготовить свой автомобиль к зиме?',
        'image': 'assets/images/sale.png',
        'id': '1',
      },
      {
        'title': 'Советы по уходу за автомобилем летом',
        'image': 'assets/images/sale.png',
        'id': '2',
      },
      {
        'title': 'Как выбрать надежные шины?',
        'image': 'assets/images/sale.png',
        'id': '3',
      },
    ];

    return Layouts(currentIndex: 1, slivers: [
      SliverToBoxAdapter(
          child: Animate(
        effects: const [FadeEffect()],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Рекомендации',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true, // Добавляем для ограничения высоты
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: recommendations.length,
              itemBuilder: (context, index) {
                final recommendation = recommendations[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: FeaturedCard(
                      title: recommendation['title']!,
                      image: recommendation['image']!,
                      onTap: () => {
                            AutoRouter.of(context).push(
                                FeaturedIdRoute(id: recommendation['id']!)),
                          }),
                );
              },
            ),
          ],
        ),
      )),
    ]);
  }
}
