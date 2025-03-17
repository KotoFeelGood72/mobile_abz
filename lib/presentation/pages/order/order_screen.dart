import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';
import 'package:mobile_abz/app/repository/repository.dart';
import 'package:mobile_abz/presentation/widgets/layouts.dart';
import 'package:mobile_abz/presentation/widgets/ui/custom_dropdown.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

@RoutePage()
class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final ApiRepository _repository = ApiRepository();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final TextEditingController _nameController = TextEditingController();
  final _phoneController = MaskedTextController(mask: '+7 (000) 000-00-00');

  bool _isLoading = false;
  String? _selectedService;
  String? _selectedDate;
  String? _selectedTime;
  Map<String, dynamic>? _activeBooking; // Активная запись с ID

  final List<String> _services = [
    'Бронирование фар пленкой',
    'Оклейка деталей салона пленкой',
    'Оклейка полиуретановой пленкой',
    'Оклейка матовой пленкой',
    'Оклейка антигравийной пленкой',
  ];

  List<String> _dates = [];
  List<String> _times = [];

  Future<void> _clearBooking() async {
    await _secureStorage.delete(key: 'active_booking');
    setState(() {
      _activeBooking = null;
    });
    print("🗑 Локальная запись удалена");
  }

  @override
  void initState() {
    super.initState();
    _loadBooking();
    // _clearBooking();

    _generateDates();
    _generateTimes();
  }

  /// Генерация списка дат на 30 дней вперед
  void _generateDates() {
    DateTime now = DateTime.now();
    _dates = List.generate(30, (index) {
      DateTime date = now.add(Duration(days: index));
      return DateFormat('dd MMM', 'ru').format(date); // Пример: 17 Мар.
    });
  }

  /// Генерация списка времени от 00:00 до 23:00
  void _generateTimes() {
    _times =
        List.generate(24, (index) => '${index.toString().padLeft(2, '0')}:00');
  }

  /// **Загрузка сохранённой записи из Secure Storage**
  Future<void> _loadBooking() async {
    String? bookingData = await _secureStorage.read(key: 'active_booking');

    if (bookingData != null) {
      setState(() {
        _activeBooking = jsonDecode(bookingData);
      });
    }
  }

  /// **Сохранение бронирования в Secure Storage**
  Future<void> _saveBooking(Map<String, dynamic> booking) async {
    await _secureStorage.write(
        key: 'active_booking', value: jsonEncode(booking));
    setState(() {
      _activeBooking = booking;
    });
  }

  /// **Метод для бронирования**
  Future<void> _bookAppointment() async {
    if (_selectedService == null ||
        _selectedDate == null ||
        _selectedTime == null ||
        _nameController.text.isEmpty ||
        _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Заполните все поля!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    print('good');
    try {
      final bookingData = {
        "name": _nameController.text,
        "phone": _phoneController.text,
        "service": _selectedService!,
        "date": _selectedDate!,
        "time": _selectedTime!,
      };

      final response = await _repository.sendFormData(bookingData);
      print('📥 Получен ответ: $response');

      if (response.containsKey('success') &&
          response['success'].toString().toLowerCase().contains('успешно') &&
          response.containsKey('booking_id')) {
        bookingData['booking_id'] =
            response['booking_id'].toString(); // ✅ Сохраняем ID
        await _saveBooking(bookingData);

        print("✅ Запись сохранена: $bookingData");

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Вы успешно записались!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception('Ошибка при создании записи');
      }
    } catch (e, stackTrace) {
      print("❌ Ошибка: $e");
      print("📌 Stack Trace: $stackTrace");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Не удалось записаться, попробуйте позже'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _cancelBooking() async {
    print("🛠 Текущее состояние _activeBooking: $_activeBooking");

    if (_activeBooking == null || !_activeBooking!.containsKey('booking_id')) {
      print("❌ _cancelBooking не вызван: нет booking_id");
      return;
    }

    setState(() => _isLoading = true);
    print(
        "✅ _cancelBooking вызван, booking_id: ${_activeBooking!['booking_id']}");

    try {
      final response = await _repository
          .cancelBooking(_activeBooking!['booking_id'].toString());
      print("📥 Ответ от API: $response");

      if (response != null && response['success'] != null) {
        // Очищаем локальные данные после успешной отмены
        await _secureStorage.delete(key: 'active_booking');
        setState(() {
          _activeBooking = null;
        });

        print("🗑 Запись успешно удалена из SecureStorage и UI обновлен");

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Запись успешно отменена'),
            backgroundColor: Colors.orange,
          ),
        );
      } else {
        throw Exception('Ошибка при отмене записи');
      }
    } catch (e, stackTrace) {
      print("❌ Ошибка в _cancelBooking: $e");
      print("📌 Stack Trace: $stackTrace");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Не удалось отменить запись, попробуйте позже'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Layouts(
      title: 'Записаться к нам',
      isLoading: _isLoading,
      currentIndex: 3,
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_activeBooking != null) ...[
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      width: double.infinity,
                      padding: EdgeInsets.all(14),
                      decoration: BoxDecoration(
                          color: Color(0xFFF8F8F8),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text('У вас уже имеется активная запись'),
                    ),
                    Container(
                      padding: EdgeInsets.all(14),
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: Color(0xFFE4E4E4)),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        _activeBooking!['service'] ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(14),
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: Color(0xFFE4E4E4)),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              _activeBooking!['date'] ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(14),
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: Color(0xFFE4E4E4)),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              _activeBooking!['time'] ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _cancelBooking,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(color: Colors.purple),
                          ),
                        ),
                        child: const Text('Отменить запись',
                            style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ] else ...[
                    Container(
                      height: 50,
                      margin: EdgeInsets.only(bottom: 5),
                      child: TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: "Имя",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 11),
                    SizedBox(
                      height: 50,
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Телефон",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomDropdown(
                      items: _services,
                      placeholder: 'Выберите услугу',
                      selectedValue: _selectedService,
                      onChanged: (value) {
                        setState(() => _selectedService = value);
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: CustomDropdown(
                            items: _dates,
                            placeholder: 'Выберите день',
                            selectedValue: _selectedDate,
                            onChanged: (value) {
                              setState(() => _selectedDate = value);
                            },
                          ),
                        ),
                        const SizedBox(width: 11),
                        Expanded(
                          flex: 2,
                          child: CustomDropdown(
                            items: _times,
                            selectedValue: _selectedTime,
                            placeholder: 'Время',
                            onChanged: (value) {
                              setState(() => _selectedTime = value);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 11),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _bookAppointment,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            )),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text('Записаться',
                                style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
