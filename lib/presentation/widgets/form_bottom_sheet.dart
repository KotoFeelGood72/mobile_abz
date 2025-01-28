import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mobile_abz/app/themes/app_colors.dart';
import 'package:mobile_abz/presentation/widgets/ui/btn.dart';

class FormBottomSheet {
  static void show({
    required BuildContext context,
    required String title,
    required String subtitle,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: _FormContent(title: title, subtitle: subtitle),
        );
      },
    );
  }
}

class _FormContent extends StatefulWidget {
  final String title;
  final String subtitle;

  const _FormContent({
    required this.title,
    required this.subtitle,
  });

  @override
  State<_FormContent> createState() => _FormContentState();
}

class _FormContentState extends State<_FormContent> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20, top: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 60,
              height: 4,
              margin: const EdgeInsets.only(bottom: 32),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Text(
            widget.title,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 8),
          Text(
            widget.subtitle,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                FormBuilderTextField(
                  name: 'name',
                  decoration: const InputDecoration(
                      labelText: 'Имя',
                      border: UnderlineInputBorder(),
                      focusColor: AppColors.pink),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'Введите имя'),
                  ]),
                ),
                const SizedBox(height: 16),
                FormBuilderTextField(
                  cursorColor: AppColors.pink,
                  name: 'phone',
                  decoration: const InputDecoration(
                      labelText: 'Телефон',
                      border: UnderlineInputBorder(),
                      focusColor: AppColors.pink),
                  keyboardType: TextInputType.phone,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Введите телефон'),
                    FormBuilderValidators.match(
                      RegExp(r'^(\\+?7|8)?9\\d{9}$'),
                      errorText: 'Введите корректный номер',
                    ),
                  ]),
                ),
                const SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'question',
                  decoration: const InputDecoration(
                      labelText: 'Вопрос (опционально)',
                      border: UnderlineInputBorder(),
                      focusColor: AppColors.pink),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
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
                    onPressed: () {
                      if (_formKey.currentState?.saveAndValidate() ?? false) {
                        final data = _formKey.currentState?.value;
                        print('Форма отправлена: $data');
                        Navigator.pop(context);
                      } else {
                        print('Форма содержит ошибки');
                      }
                    },
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
