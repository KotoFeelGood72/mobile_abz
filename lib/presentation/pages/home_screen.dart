import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mobile_abz/app/router/app_router.gr.dart';
import 'package:mobile_abz/app/themes/app_colors.dart';
import 'package:mobile_abz/presentation/widgets/Icons.dart';
import 'package:mobile_abz/presentation/widgets/gallery.dart';
import 'package:mobile_abz/presentation/widgets/layouts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mobile_abz/presentation/widgets/reviews_summary.dart';
import 'package:mobile_abz/presentation/widgets/sale_slider.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CarouselSliderController _controller = CarouselSliderController();
  int _currentIndex = 0;

  final List<Map<String, String>> services = [
    {
      'title': 'Защита пленкой',
      'image': 'assets/images/sale.png',
    },
    {
      'title': 'Антидождь',
      'image': 'assets/images/sale.png',
    },
    {
      'title': 'Антидождь',
      'image': 'assets/images/sale.png',
    },
    {
      'title': 'Полировка',
      'image': 'assets/images/sale.png',
    },
    {
      'title': 'Химчистка',
      'image': 'assets/images/sale.png',
    },
  ];

  final galleryData = [
    {
      'items': [
        {'image': 'assets/images/sale.png', 'title': 'Слайд 1'},
        {'image': 'assets/images/sale.png', 'title': 'Слайд 1'},
      ],
    },
    {
      'items': [
        {'image': 'assets/images/sale.png', 'title': 'Слайд 1'},
        {'image': 'assets/images/sale.png', 'title': 'Слайд 1'},
      ],
    },
    {
      'items': [
        {'image': 'assets/images/sale.png', 'title': 'Слайд 1'},
        {'image': 'assets/images/sale.png', 'title': 'Слайд 1'},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Animate(
      child: Layouts(
        currentIndex: 0,
        slivers: [
          SliverToBoxAdapter(
            child: Animate(
              delay: const Duration(milliseconds: 200),
              effects: const [
                FadeEffect(),
              ],
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SaleSlider(),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Услуги нашего салона',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: _currentIndex > 0
                                    ? () {
                                        _controller.previousPage().then((_) {
                                          setState(() {
                                            _currentIndex--;
                                          });
                                        });
                                      }
                                    : null,
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  padding: const EdgeInsets.all(9),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: _currentIndex > 0
                                          ? AppColors.pink
                                          : const Color(0xFFEDEDED),
                                    ),
                                    color: _currentIndex > 0
                                        ? AppColors.pink
                                        : AppColors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: IconWidget(
                                    iconName: 'arrow-left',
                                    color: _currentIndex > 0
                                        ? AppColors.white
                                        : AppColors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: _currentIndex < services.length - 1
                                    ? () {
                                        _controller.nextPage().then((_) {
                                          setState(() {
                                            _currentIndex++;
                                          });
                                        });
                                      }
                                    : null,
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  padding: const EdgeInsets.all(9),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: _currentIndex < services.length - 1
                                          ? AppColors.pink
                                          : const Color(0xFFEDEDED),
                                    ),
                                    color: _currentIndex < services.length - 1
                                        ? AppColors.pink
                                        : AppColors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: IconWidget(
                                    iconName: 'arrow-right',
                                    color: _currentIndex < services.length - 1
                                        ? AppColors.white
                                        : AppColors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    CarouselSlider(
                      items: services.map((service) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(16.0),
                                    ),
                                    child: Image.asset(
                                      service['image']!,
                                      height: 125,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(16),
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: Text(
                                      service['title']!,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }).toList(),
                      carouselController: _controller,
                      options: CarouselOptions(
                        autoPlay: false,
                        enableInfiniteScroll: false,
                        viewportFraction: .35,
                        aspectRatio: 2.0,
                        initialPage: 0,
                        padEnds: false,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                    ),
                    Gallery(galleryData: galleryData),
                    ReviewsSummary(
                      totalReviews: 176,
                      rating: 4.9,
                      totalRatings: 412,
                      onSeeAll: () {
                        AutoRouter.of(context).push(const ReviewsRoute());
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
