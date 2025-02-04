import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_abz/app/repository/repository.dart';
import 'package:mobile_abz/app/router/app_router.gr.dart';
import 'package:mobile_abz/app/themes/app_colors.dart';
import 'package:mobile_abz/presentation/widgets/card/reviews_card.dart';
import 'package:mobile_abz/presentation/widgets/layouts.dart';
import 'package:mobile_abz/presentation/widgets/reviews_summary.dart';

@RoutePage()
class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  final ApiRepository _repository = ApiRepository();
  List<dynamic> _reviews = [];

  double _averageRating = 0.0;
  int _totalReviews = 0;
  Map<int, int> _ratingDistribution = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchReviews();
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
    } finally {
      setState(() {
        _isLoading = false;
      });
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

  @override
  Widget build(BuildContext context) {
    return Layouts(
      isLoading: _isLoading,
      currentIndex: 0,
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            decoration: const BoxDecoration(color: AppColors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReviewsSummary(
                  totalReviews: _totalReviews,
                  rating: _averageRating,
                  totalRatings: _totalReviews,
                  ratingDistribution: _ratingDistribution,
                  onBack: () {
                    Navigator.of(context).pop();
                  },
                  onSeeAll: () {
                    AutoRouter.of(context).push(const ReviewsRoute());
                  },
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                  child: Text(
                    '$_totalReviews отзывов',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _reviews.length,
                  itemBuilder: (context, index) {
                    final review = _reviews[index];

                    final acf = review['acf'] ?? {};
                    final name = acf['name'] ?? 'Аноним';
                    final level = acf['level'] ?? 'Без уровня';
                    final reviewText = acf['review'] ?? 'Без отзыва';
                    final date = acf['date'] ?? '';
                    final stars = int.tryParse(acf['stars'] ?? '0') ?? 0;
                    final profileImage =
                        (acf['img'] is String) ? acf['img'] : "";

                    return ReviewsCard(
                      name: name,
                      level: level,
                      reviewText: reviewText,
                      date: date,
                      stars: stars,
                      profileImage: profileImage.isNotEmpty ? profileImage : "",
                      gallery: [],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
