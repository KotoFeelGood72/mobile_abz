import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mobile_abz/app/repository/repository.dart';
import 'package:mobile_abz/app/router/app_router.gr.dart';
import 'package:mobile_abz/presentation/widgets/featured_card.dart';
import 'package:mobile_abz/presentation/widgets/layouts.dart';

@RoutePage()
class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final ApiRepository _repository = ApiRepository();
  List<Map<String, String>> _Portfolios = [];

  @override
  void initState() {
    super.initState();
    _fetchPortfolio();
  }

  /// 📌 Загружаем рекомендации из API
  Future<void> _fetchPortfolio() async {
    try {
      final data = await _repository
          .fetchData('recommendations/all-recommendations.json');
      setState(() {
        _Portfolios = _extractRecommendations(data);
      });
    } catch (e) {
      print('Error: $e');
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
    return Layouts(currentIndex: 1, slivers: [
      SliverToBoxAdapter(
          child: Animate(
        effects: const [FadeEffect()],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Рекомендации',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 16),

            /// 📌 Отображаем рекомендации
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _Portfolios.length,
              itemBuilder: (context, index) {
                final recommendation = _Portfolios[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: FeaturedCard(
                    title: recommendation['title']!,
                    image: recommendation['image']!,
                    onTap: () => AutoRouter.of(context).push(
                      PortfolioIdRoute(id: recommendation['id']!),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      )),
    ]);
  }
}
