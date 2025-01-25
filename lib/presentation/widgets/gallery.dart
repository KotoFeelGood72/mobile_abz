import 'package:flutter/material.dart';
import 'package:mobile_abz/presentation/widgets/image_slider.dart';
import 'package:mobile_abz/presentation/widgets/ui/btn.dart';

class Gallery extends StatefulWidget {
  final List<Map<String, dynamic>> galleryData; // Данные для галереи

  const Gallery({
    super.key,
    required this.galleryData,
  });

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  bool showAll = false; // Флаг для отображения всех элементов

  @override
  Widget build(BuildContext context) {
    final dataToShow =
        showAll ? widget.galleryData : widget.galleryData.take(2).toList();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Галерея работ',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          // Список слайдеров
          Column(
            children: dataToShow.map((data) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ImageSlider(
                  items: data['items'],
                  height: 158,
                ),
              );
            }).toList(),
          ),
          if (!showAll && widget.galleryData.length > 2)
            Center(
              child: Btn(
                onPressed: () {
                  setState(() {
                    showAll = true;
                  });
                },
                name: 'Показать все',
              ),
            ),
        ],
      ),
    );
  }
}
