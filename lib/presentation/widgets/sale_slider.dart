import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mobile_abz/app/router/app_router.gr.dart';
import 'package:mobile_abz/app/themes/app_colors.dart';

class SaleSlider extends StatefulWidget {
  final List<Map<String, dynamic>> slides;
  const SaleSlider({super.key, required this.slides});

  @override
  State<SaleSlider> createState() => _SaleSliderState();
}

class _SaleSliderState extends State<SaleSlider> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Text(
              "Скидки и акции",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          CarouselSlider(
            items: widget.slides.map((slide) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            slide['acf']['img'] is String &&
                                    slide['acf']['img'].isNotEmpty
                                ? slide['acf']['img']
                                : 'https://via.placeholder.com/400', // Заглушка изображения
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child; // Картинка загружена
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
                                              1)
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.image_not_supported,
                                        color: Colors.grey, size: 50),
                                    const SizedBox(height: 5),
                                    Text("Не удалось загрузить",
                                        style: TextStyle(color: Colors.grey)),
                                  ],
                                ),
                              );
                            },
                          ),
                          Positioned(
                            bottom: 16,
                            left: 16,
                            right: 16,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  (slide['title'] ?? ''),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ElevatedButton(
                                  onPressed: () {
                                    AutoRouter.of(context).push(SaleIdRoute(
                                        id: slide['id'].toString()!));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        AppColors.white.withOpacity(0.2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    "Узнать подробнее",
                                    style: TextStyle(color: AppColors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              height: 195,
              viewportFraction: .96,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 10),
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentPage = index;
                });
              },
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.slides.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                width: 15.0,
                height: 15.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: _currentPage == index
                      ? Border.all(color: AppColors.pink, width: 2.0)
                      : null,
                ),
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: _currentPage == index ? 7.0 : 10.0,
                    height: _currentPage == index ? 7.0 : 10.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == index
                          ? AppColors.pink
                          : const Color(0xFFF1F1F1),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Divider(
            height: 1,
            color: Color(0xFFEDEDED),
          )
        ],
      ),
    );
  }
}
