import 'package:flutter/material.dart';
import 'package:mobile_abz/presentation/widgets/Icons.dart';
import 'package:mobile_abz/presentation/widgets/ui/btn.dart';

class ReviewsSummary extends StatelessWidget {
  final int totalReviews;
  final double rating;
  final int totalRatings;
  final Map<int, int>
      ratingDistribution; // ✅ Добавили параметр для количества звезд
  final VoidCallback onSeeAll;
  final VoidCallback? onBack;

  const ReviewsSummary({
    super.key,
    required this.totalReviews,
    required this.rating,
    required this.totalRatings,
    required this.ratingDistribution, // ✅ Добавляем в конструктор
    required this.onSeeAll,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (onBack != null)
                GestureDetector(
                  onTap: onBack,
                  child: const SizedBox(
                      width: 16, child: IconWidget(iconName: 'arrow-left')),
                ),
              SizedBox(width: onBack != null ? 10 : 0),
              Text(
                '$totalReviews отзывов',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          /// 🎯 **Общий рейтинг**
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                // Средний рейтинг
                Text(rating.toStringAsFixed(1),
                    style: const TextStyle(
                        fontSize: 48,
                        color: Color(0xFF4D4D4D),
                        fontWeight: FontWeight.w600)),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < rating.round()
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.yellow.shade600,
                            size: 20,
                          );
                        }),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$totalRatings оценок',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          const SizedBox(height: 16),
          if (onBack == null)
            Center(
              child: Btn(
                onPressed: onSeeAll,
                name: 'Открыть все отзывы',
              ),
            ),
        ],
      ),
    );
  }
}
