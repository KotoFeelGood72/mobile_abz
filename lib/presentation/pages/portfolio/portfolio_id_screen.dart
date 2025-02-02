import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:mobile_abz/app/themes/app_colors.dart';
import 'package:mobile_abz/presentation/widgets/Icons.dart';
import 'package:mobile_abz/presentation/widgets/layouts.dart';

@RoutePage()
class FeaturedIdScreen extends StatelessWidget {
  final String id;

  const FeaturedIdScreen({
    super.key,
    @PathParam('id') required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      'assets/images/sale.png',
      'assets/images/sale.png',
      'assets/images/sale.png',
    ];

    return Layouts(currentIndex: 1, slivers: [
      SliverToBoxAdapter(
          child: Animate(
        effects: const [FadeEffect()],
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const IconWidget(
                              iconName: 'arrow-left',
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Рекомендации',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ],
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    SizedBox(
                      height: 318,
                      child: Swiper(
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Container(
                              child: Image.asset(
                                images[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                        pagination: SwiperCustomPagination(
                          builder: (BuildContext context,
                              SwiperPluginConfig config) {
                            return Positioned(
                              bottom: 16,
                              left: 16,
                              right: 16,
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  final double totalWidth =
                                      constraints.maxWidth;
                                  const double spacing = 8.0;
                                  final int itemsCount = images.length;

                                  final double inactiveWidth = (totalWidth -
                                          spacing * (itemsCount - 1)) /
                                      (itemsCount + 1);

                                  final double activeWidth = inactiveWidth * 2;

                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      itemsCount,
                                      (index) {
                                        final isActive =
                                            index == config.activeIndex;
                                        return AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          width: isActive
                                              ? activeWidth
                                              : inactiveWidth,
                                          height: 4,
                                          decoration: BoxDecoration(
                                            color: isActive
                                                ? Colors.white
                                                : Colors.white.withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          margin: EdgeInsets.only(
                                              right: index < itemsCount - 1
                                                  ? spacing
                                                  : 0),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Ну какова красота!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Наши услуги:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                '■ Антигравийная пленка\n■ Защита экранов и консолей\n■ Детейлинг мойка и химчистка\n■ Детейлинг полировка и защита керамикой\n■ Тонировка и бронирование стекол\n■ Шумоизоляция',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Наша студия:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '5-Донской пр-д, 19\nТелефон для консультации и записи:\n+7 (495) 120-18-36',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      )),
    ]);
  }
}
