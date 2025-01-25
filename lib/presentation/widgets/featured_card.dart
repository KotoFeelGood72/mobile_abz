import 'package:flutter/material.dart';

class FeaturedCard extends StatelessWidget {
  final String title;
  final String image;
  final String id;
  const FeaturedCard(
      {super.key, required this.title, required this.image, required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // ClipRRect(child: Image.network(image)),
          Text(title),
        ],
      ),
    );
  }
}
