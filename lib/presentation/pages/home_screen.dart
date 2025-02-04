import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mobile_abz/app/repository/repository.dart';
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
  final ApiRepository _repository = ApiRepository();
  dynamic _sales = [];
  dynamic _services = [];
  dynamic _gallery = [];
  List<dynamic> _reviews = [];

  double _averageRating = 0.0;
  int _totalReviews = 0;
  Map<int, int> _ratingDistribution = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};

  bool _isLoading = true; // Флаг загрузки

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      await Future.wait([
        _fetchSales(),
        _fetchServices(),
        _fetchGallery(),
        _fetchReviews(),
      ]);
    } finally {
      setState(() {
        _isLoading = false; // Отключаем лоадер после загрузки данных
      });
    }
  }

  Future<void> _fetchSales() async {
    try {
      final data = await _repository.fetchData('stocks/all-stocks.json');
      setState(() {
        _sales = data;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _fetchReviews() async {
    try {
      final data = await _repository.fetchData('reviews/all-reviews.json');
      setState(() {
        _reviews = data;
        _calculateReviewStats();
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void _calculateReviewStats() {
    if (_reviews.isEmpty) return;

    double totalStars = 0;
    int totalReviews = _reviews.length;
    Map<int, int> ratingDistribution = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};

    for (var review in _reviews) {
      final acf = review['acf'] ?? {};
      int stars = int.tryParse(acf['stars'] ?? '0') ?? 0;
      if (stars < 1 || stars > 5) continue;

      totalStars += stars;
      ratingDistribution[stars] = ratingDistribution[stars]! + 1;
    }

    setState(() {
      _averageRating = totalStars / totalReviews;
      _totalReviews = totalReviews;
      _ratingDistribution = ratingDistribution;
    });
  }

  Future<void> _fetchGallery() async {
    try {
      final data = await _repository.fetchData('gallery/all-gallery.json');
      setState(() {
        _gallery = data;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _fetchServices() async {
    try {
      final data = await _repository.fetchData('services/all-services.json');
      setState(() {
        _services = data;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Animate(
      child: Layouts(
        isLoading: _isLoading, // Передаем актуальное состояние загрузки
        currentIndex: 0,
        slivers: [
          SliverToBoxAdapter(
            child: Animate(
              delay: const Duration(milliseconds: 200),
              effects: const [
                FadeEffect(),
              ],
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_sales.isNotEmpty)
                      SaleSlider(
                          slides: List<Map<String, dynamic>>.from(_sales)),
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
                                onTap: _currentIndex < _services.length - 1
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
                                      color:
                                          _currentIndex < _services.length - 1
                                              ? AppColors.pink
                                              : const Color(0xFFEDEDED),
                                    ),
                                    color: _currentIndex < _services.length - 1
                                        ? AppColors.pink
                                        : AppColors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: IconWidget(
                                    iconName: 'arrow-right',
                                    color: _currentIndex < _services.length - 1
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
                    if (_services.isNotEmpty)
                      CarouselSlider(
                        items: _services.map<Widget>((service) {
                          return Builder(
                            builder: (BuildContext context) {
                              return GestureDetector(
                                onTap: () => AutoRouter.of(context).push(
                                    ServicesIdRoute(
                                        id: service['id'].toString())),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(16.0),
                                        ),
                                        child: Image.network(
                                          service['acf']['img']!,
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
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                        carouselController: _controller,
                        options: CarouselOptions(
                          autoPlay: false,
                          enableInfiniteScroll: false,
                          viewportFraction: .5,
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
                    if (_gallery.isNotEmpty)
                      Gallery(
                          galleryData:
                              List<Map<String, dynamic>>.from(_gallery)),
                    ReviewsSummary(
                      totalReviews: _totalReviews,
                      rating: _averageRating,
                      totalRatings: _totalReviews,
                      ratingDistribution: _ratingDistribution,
                      onSeeAll: () {
                        AutoRouter.of(context).push(const ReviewsRoute());
                      },
                    ),
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
