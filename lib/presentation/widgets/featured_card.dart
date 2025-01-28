import 'package:flutter/material.dart';

class FeaturedCard extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onTap;
  const FeaturedCard(
      {super.key,
      required this.title,
      required this.image,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(child: Image.asset(image)),
            const SizedBox(height: 10),
            Text(title),
          ],
        ),
      ),
    );
  }
}
