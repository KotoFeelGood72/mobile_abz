import 'package:flutter/material.dart';
import 'package:mobile_abz/presentation/widgets/image_slider.dart';
import 'package:mobile_abz/presentation/widgets/ui/btn.dart';

class Gallery extends StatefulWidget {
  final List<Map<String, dynamic>> galleryData;

  const Gallery({
    super.key,
    required this.galleryData,
  });

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  bool showAll = false;

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
              List<Map<String, String>> images = _extractImages(data);

              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ImageSlider(
                  items: images,
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

  List<Map<String, String>> _extractImages(Map<String, dynamic> data) {
    if (data.containsKey('acf') && data['acf'] is Map<String, dynamic>) {
      List<dynamic> gallery = data['acf']['gallery'] ?? [];
      return gallery
          .map<Map<String, String>>((item) => {"img": item['img'] as String})
          .toList();
    }
    return [];
  }
}
