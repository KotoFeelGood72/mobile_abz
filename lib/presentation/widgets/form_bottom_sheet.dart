import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mobile_abz/app/themes/app_colors.dart';
import 'package:mobile_abz/app/repository/repository.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

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
  final ApiRepository _repository = ApiRepository();
  final _phoneController =
      MaskedTextController(mask: '+7 (000) 000-00-00'); // Маска для телефона
  bool _isLoading = false;

  Future<void> _submitForm() async {
    print('Началась обработка формы'); // ✅ Лог начала обработки формы

    if (_formKey.currentState?.saveAndValidate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      final formData = _formKey.currentState?.value ?? {};
      final phone = _phoneController.text
          .replaceAll(RegExp(r'[^0-9]'), ''); // Убираем все символы кроме цифр

      print('Собранные данные: $formData'); // ✅ Лог данных перед отправкой
      print('Отправляемый номер телефона: $phone'); // ✅ Лог формата номера

      try {
        final response = await _repository.sendFormData({
          'name': formData['name'],
          'phone': phone,
          'message': formData['question'] ?? '',
        });

        print('Ответ сервера: $response'); // ✅ Лог ответа сервера

        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Форма успешно отправлена!'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      } catch (e) {
        print('Ошибка при отправке: $e'); // ✅ Лог ошибки

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Ошибка при отправке: $e'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
        print('Обработка формы завершена'); // ✅ Лог завершения
      }
    } else {
      print(
          'Форма содержит ошибки: ${_formKey.currentState?.errors}'); // ✅ Лог ошибок валидации
    }
  }

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
                  controller: _phoneController, // Подключаем маску
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
                        color: AppColors.pink.withOpacity(0.5),
                        blurRadius: 11.6,
                        spreadRadius: 2,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
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
