import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mobile_abz/app/repository/repository.dart';
import 'package:mobile_abz/app/router/app_router.gr.dart';
import 'package:mobile_abz/presentation/widgets/featured_card.dart';
import 'package:mobile_abz/presentation/widgets/layouts.dart';

@RoutePage()
class FeaturedScreen extends StatefulWidget {
  const FeaturedScreen({super.key});

  @override
  State<FeaturedScreen> createState() => _FeaturedScreenState();
}

class _FeaturedScreenState extends State<FeaturedScreen> {
  final ApiRepository _repository = ApiRepository();
  List<Map<String, String>> _featureds = [];
  bool _isLoading = true; // Флаг загрузки

  @override
  void initState() {
    super.initState();
    _fetchFeatured();
  }

  /// 📌 Загружаем рекомендации из API
  Future<void> _fetchFeatured() async {
    try {
      final data = await _repository
          .fetchData('recommendations/all-recommendations.json');
      setState(() {
        _featureds = _extractRecommendations(data);
      });
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false; // Отключаем лоадер после загрузки данных
      });
    }
  }

  List<Map<String, String>> _extractRecommendations(List<dynamic> data) {
    return data.map<Map<String, String>>((item) {
      final acf = item['acf'] ?? {};
      return {
        'title': (acf['description'] ?? 'Без описания').toString(),
        'image': (acf['img'] ?? 'assets/images/default.jpg').toString(),
        'id': item['id'].toString(),
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Layouts(
      isLoading: _isLoading, // Передаем состояние загрузки
      currentIndex: 1,
      title: 'Рекомендации',
      slivers: [
        SliverToBoxAdapter(
          child: Animate(
            effects: const [FadeEffect()],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                const SizedBox(height: 16),

                /// 📌 Отображаем рекомендации
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _featureds.length,
                  itemBuilder: (context, index) {
                    final recommendation = _featureds[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: FeaturedCard(
                        title: recommendation['title']!,
                        image: recommendation['image']!,
                        onTap: () => AutoRouter.of(context).push(
                          FeaturedIdRoute(id: recommendation['id']!),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
