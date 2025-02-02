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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(image),
            ),
            Html(
              data: title,
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
