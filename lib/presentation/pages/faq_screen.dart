import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mobile_abz/app/repository/repository.dart';
import 'package:mobile_abz/app/themes/app_colors.dart';
import 'package:mobile_abz/presentation/widgets/form_bottom_sheet.dart';
import 'package:mobile_abz/presentation/widgets/layouts.dart';
import 'package:mobile_abz/presentation/widgets/Icons.dart';

@RoutePage()
class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  int? _expandedIndex;
  final ApiRepository _repository = ApiRepository();
  List<Map<String, String>> _faqs = [];

  Future<void> _fetchFaqs() async {
    try {
      final data = await _repository.fetchData('/acf-options.json');

      if (data != null && data.containsKey('faq')) {
        setState(() {
          _faqs = List<Map<String, String>>.from(
            (data['faq'] as List).map(
              (item) => {
                "question": item["questions"].toString().runes.toList() ??
                    "Без вопроса",
                "answer":
                    item["response"].toString().runes.toList() ?? "Без ответа",
              },
            ),
          );
        });
      } else {
        print("Ошибка: В JSON нет ключа 'faq'");
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _toggleExpansion(int index) {
    setState(() {
      _expandedIndex = (_expandedIndex == index) ? null : index; // Переключение
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchFaqs();
  }

  @override
  Widget build(BuildContext context) {
    return Layouts(
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          margin:
              const EdgeInsets.symmetric(horizontal: 16), // Отступы по бокам
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.pink
                    .withOpacity(0.5), // Цвет тени с прозрачностью
                blurRadius: 11.6, // Радиус размытия
                spreadRadius: 2, // Распространение тени
                offset: const Offset(0, 4), // Смещение тени
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () => FormBottomSheet.show(
              context: context,
              title: 'Свяжитесь с нами',
              subtitle:
                  'Заполните форму, и мы свяжемся с вами в ближайшее время.',
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text(
              'Связаться с нами',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      currentIndex: 2,
      slivers: [
        SliverToBoxAdapter(
            child: Animate(
          effects: const [FadeEffect()],
          child: Container(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  itemCount: _faqs.length,
                  itemBuilder: (context, index) {
                    return CustomFaqItem(
                      question: _faqs[index]['question']!,
                      answer: _faqs[index]['answer']!,
                      isExpanded: _expandedIndex == index,
                      onToggle: () => _toggleExpansion(index),
                    );
                  },
                ),
              ],
            ),
          ),
        )),
      ],
    );
  }
}

class CustomFaqItem extends StatefulWidget {
  final String question;
  final String answer;
  final bool isExpanded;
  final VoidCallback onToggle;

  const CustomFaqItem({
    super.key,
    required this.question,
    required this.answer,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  State<CustomFaqItem> createState() => _CustomFaqItemState();
}

class _CustomFaqItemState extends State<CustomFaqItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(CustomFaqItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: widget.onToggle,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.question,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _animationController.value * 3.14159, // Поворот
                        child: const IconWidget(
                          iconName: 'up',
                          color: AppColors.pink,
                          size: 16,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          SizeTransition(
            sizeFactor: _animationController,
            child: Padding(
              padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
              child: Text(
                widget.answer,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF7E7E7E),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
