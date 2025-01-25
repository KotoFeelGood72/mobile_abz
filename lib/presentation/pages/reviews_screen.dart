import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_abz/app/router/app_router.gr.dart';
import 'package:mobile_abz/app/themes/app_colors.dart';
import 'package:mobile_abz/presentation/widgets/card/reviews_card.dart';
import 'package:mobile_abz/presentation/widgets/layouts.dart';
import 'package:mobile_abz/presentation/widgets/reviews_summary.dart';

@RoutePage()
class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Массив отзывов
    final List<Map<String, dynamic>> reviews = [
      {
        "name": "Seva Che",
        "level": "Знаток города 14 уровня",
        "reviewText":
            "Невероятно классный сервис, все делают очень профессионально, аккуратно и внимательно. Сбалансированные цены...",
        "date": "25 августа 2024",
        "stars": 5,
        "profileImage": "assets/images/sale.png",
        "gallery": [
          "assets/images/sale.png",
          "assets/images/sale.png",
        ],
      },
      {
        "name": "Алёна S",
        "level": "Знаток города 14 уровня",
        "reviewText":
            "Отличное место и отличные ребята. Очень нравится обслуживание, все на высоте и без пафоса! Любые вопросы...",
        "date": "25 августа 2024",
        "stars": 5,
        "profileImage": "assets/images/sale.png",
        "gallery": [
          "assets/images/sale.png",
        ],
      },
      // Добавьте больше отзывов при необходимости
    ];

    return Layouts(currentIndex: 3, slivers: [
      SliverToBoxAdapter(
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReviewsSummary(
                totalReviews: reviews.length,
                rating: 4.9,
                totalRatings: 412,
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
                  '${reviews.length} отзывов',
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  final review = reviews[index];
                  return ReviewsCard(
                    name: review['name'],
                    level: review['level'],
                    reviewText: review['reviewText'],
                    date: review['date'],
                    stars: review['stars'],
                    profileImage: review['profileImage'],
                    gallery: List<String>.from(review['gallery']),
                  );
                },
              ),
            ],
          ),
        ),
      )
    ]);
  }
}
