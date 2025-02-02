import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mobile_abz/app/repository/repository.dart';
import 'package:mobile_abz/app/themes/app_colors.dart';
import 'package:mobile_abz/presentation/widgets/Icons.dart';
import 'package:mobile_abz/presentation/widgets/form_bottom_sheet.dart';
import 'package:mobile_abz/presentation/widgets/layouts.dart';
import 'package:mobile_abz/presentation/widgets/ui/btn.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final ApiRepository _repository = ApiRepository();
  Map<String, dynamic>? _contacts; // Контакты
  bool _isLoading = true; // Флаг загрузки

  Future<void> _fetchContacts() async {
    try {
      final data = await _repository.fetchData('acf-options.json');

      if (data != null) {
        setState(() {
          _contacts = Map<String, dynamic>.from(data)..remove('faq');
        });
      } else {
        print("Ошибка: JSON пуст");
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false; // Отключаем лоадер после загрузки данных
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Layouts(
      isLoading: _isLoading, // Передаем состояние загрузки
      floatingActionButton: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.pink.withOpacity(0.5),
              blurRadius: 11.6,
              spreadRadius: 2,
              offset: const Offset(0, 4),
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
            'Заказать звонок',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      currentIndex: 3,
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Animate(
            effects: const [FadeEffect()],
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Контакты',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 15),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            'assets/images/map.png',
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            IconWidget(
                              iconName: 'marker',
                              size: 16,
                              color: AppColors.pink,
                            ),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: Text(
                                '5-ый Донской проезд, дом 19 ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        if (_contacts != null &&
                            _contacts!['link_to_map'] != null)
                          Btn(
                            onPressed: () {
                              launchUrl(Uri.parse(_contacts!['link_to_map']));
                            },
                            name: 'Проложить маршрут',
                            borderColor: AppColors.pink,
                            textColor: AppColors.pink,
                          ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.grey[300]!),
                        bottom: BorderSide(color: Colors.grey[300]!),
                      ),
                    ),
                    child: ContactRow(
                      icon: 'phone',
                      color: AppColors.pink,
                      text: _contacts?['phone'] ?? 'Телефон не указан',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        if (_contacts?['whatsapp'] != null)
                          ContactRow(
                            icon: 'wa',
                            color: Colors.green,
                            text: _contacts!['whatsapp'],
                          ),
                        if (_contacts?['telegram'] != null)
                          const SizedBox(width: 16),
                        if (_contacts?['telegram'] != null)
                          ContactRow(
                            icon: 'tg',
                            color: Colors.blue,
                            text: _contacts!['telegram'],
                          ),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ContactRow extends StatelessWidget {
  final String icon;
  final Color color;
  final String text;

  const ContactRow({
    super.key,
    required this.icon,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconWidget(iconName: icon, size: 16, color: color),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
