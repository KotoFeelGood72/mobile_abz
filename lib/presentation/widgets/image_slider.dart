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
  List<bool> _isLoadingList = [];

  @override
  void initState() {
    super.initState();
    _isLoadingList = List<bool>.filled(
        widget.items.length, true); // Изначально все загружаются
  }

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
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: _isLoadingList[index] ? 0 : 1,
                          child: Image.network(
                            item['img']!,
                            width: double.infinity,
                            height: widget.height,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                Future.delayed(
                                    const Duration(milliseconds: 200), () {
                                  setState(() {
                                    _isLoadingList[index] =
                                        false; // Изображение загружено
                                  });
                                });
                                return child;
                              }
                              return const SizedBox(); // Скроем, пока загружается
                            },
                          ),
                        ),
                      ),
                    ),
                    if (_isLoadingList[index])
                      const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Colors.white,
                        ),
                      ),
                  ],
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
              child: _buildIndicator(),
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

  Widget _buildIndicator() {
    final double totalWidth = MediaQuery.of(context).size.width * 0.8;
    const double spacing = 8.0;
    final int itemsCount = widget.items.length;

    final double inactiveWidth =
        (totalWidth - spacing * (itemsCount - 1)) / (itemsCount + 1);
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
              color: isActive ? Colors.white : Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(4),
            ),
            margin:
                EdgeInsets.only(right: index < itemsCount - 1 ? spacing : 0),
          );
        },
      ),
    );
  }
}
