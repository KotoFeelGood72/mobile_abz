import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  final List<Map<String, String>> items; // Список изображений и заголовков
  final double height; // Высота слайдера

  const ImageSlider({
    super.key,
    required this.items,
    this.height = 250,
  });

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final CarouselSliderController _controller = CarouselSliderController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          children: [
            CarouselSlider.builder(
              carouselController: _controller,
              itemCount: widget.items.length,
              itemBuilder: (context, index, realIndex) {
                final item = widget.items[index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    item['image']!,
                    width: double.infinity,
                    height: widget.height,
                    fit: BoxFit.cover,
                  ),
                );
              },
              options: CarouselOptions(
                autoPlay: false,
                height: widget.height,
                viewportFraction: 1.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final double totalWidth = constraints.maxWidth;
                  const double spacing = 8.0;
                  final int itemsCount = widget.items.length;

                  final double inactiveWidth =
                      (totalWidth - spacing * (itemsCount - 1)) /
                          (itemsCount + 1);

                  final double activeWidth = inactiveWidth * 2;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      itemsCount,
                      (index) {
                        final isActive = index == _currentIndex;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: isActive ? activeWidth : inactiveWidth,
                          height: 4,
                          decoration: BoxDecoration(
                            color: isActive
                                ? Colors.white
                                : Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          margin: EdgeInsets.only(
                              right: index < itemsCount - 1 ? spacing : 0),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 9),
        Text(
          widget.items[_currentIndex]['title'] ?? '',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
