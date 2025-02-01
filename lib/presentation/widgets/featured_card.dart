import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class FeaturedCard extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  const FeaturedCard({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
  });

  /// 📌 Декодируем текст в UTF-8
  String decodeUtf8(String text) {
    return utf8.decode(text.runes.toList());
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              child: Image.network(image),
              borderRadius: BorderRadius.circular(20),
            ),
            Html(
              data: decodeUtf8(title),
              style: {
                "p": Style(
                  color: Colors.black87,
                ),
              },
            ),
          ],
        ),
      ),
    );
  }
}
