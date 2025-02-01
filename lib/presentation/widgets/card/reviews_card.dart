import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_abz/app/themes/app_colors.dart';

class ReviewsCard extends StatelessWidget {
  final String name; // Имя автора отзыва
  final String level; // Уровень автора
  final String reviewText; // Текст отзыва
  final String date; // Дата отзыва
  final int stars; // Количество звезд
  final String profileImage; // URL изображения профиля
  final List<String> gallery; // Список URL изображений в галерее

  const ReviewsCard({
    super.key,
    required this.name,
    required this.level,
    required this.reviewText,
    required this.date,
    required this.stars,
    required this.profileImage,
    this.gallery = const [], // Галерея опциональна
  });

  String decodeUtf8(String text) {
    return utf8.decode(text.runes.toList());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Верхний блок с профилем
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(profileImage),
                  radius: 24,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      decodeUtf8(name),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(decodeUtf8(level),
                        style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Рейтинг и дата
            Row(
              children: [
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < stars ? Icons.star : Icons.star_border,
                      color: Colors.yellow.shade600,
                      size: 20,
                    );
                  }),
                ),
                const SizedBox(width: 8),
                Text(
                  decodeUtf8(date),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              decodeUtf8(reviewText),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            if (gallery.isNotEmpty)
              SizedBox(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: gallery.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        gallery[index],
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
