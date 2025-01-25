import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_abz/presentation/widgets/layouts.dart';

@RoutePage()
class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> faqItems = [
      {
        'question': 'Сколько будет стоить антигравийная пленка на машину?',
        'answer': 'Цена зависит от марки автомобиля и выбранной пленки.',
      },
      {
        'question': 'Какой пленкой вы оклеиваете?',
        'answer':
            'Мы используем только сертифицированные пленки высокого качества.',
      },
      {
        'question': 'На сколько нужно оставлять машину?',
        'answer': 'В среднем процесс занимает от 1 до 2 дней.',
      },
      {
        'question': 'У вас есть гарантия?',
        'answer': 'Да, мы предоставляем гарантию на все выполненные работы.',
      },
      {
        'question': 'Сколько будет стоить забронировать стекло?',
        'answer': 'Цена варьируется в зависимости от типа стекла и автомобиля.',
      },
      {
        'question': 'Почему так дорого? Нашел гораздо дешевле!',
        'answer':
            'Мы предоставляем высокое качество работ и долговечность результата.',
      },
      {
        'question': 'Заклеить фары пленкой?',
        'answer':
            'Да, мы защищаем фары полиуретановой антигравийной пленкой. Это помогает предотвратить преждевременное старение пластика и образование на нем механических повреждений.',
      },
    ];

    return Layouts(
      currentIndex: 2,
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Часто задаваемые вопросы',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: faqItems.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F8F8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          dividerColor: Colors.transparent,
                        ),
                        child: ExpansionTile(
                          tilePadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          title: Text(
                            faqItems[index]['question'].toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          iconColor: const Color(0xFF7E7E7E),
                          collapsedIconColor: const Color(0xFF7E7E7E),
                          childrenPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          expandedAlignment: Alignment.centerLeft,
                          children: [
                            Text(
                              faqItems[index]['answer'].toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF7E7E7E),
                              ),
                            ),
                          ],
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
