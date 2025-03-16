import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiRepository {
  // Получаем базовый URL из .env
  final String baseUrl = dotenv.env['API_URL'] ?? '';

  // Пример GET-запроса
  Future<dynamic> fetchData(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));

    if (response.statusCode == 200) {
      // Декодируем как UTF-8
      final decodedJson = utf8.decode(response.bodyBytes);
      return jsonDecode(decodedJson);
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Пример POST-запроса
  Future<dynamic> postData(String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // Декодируем как UTF-8
      final decodedJson = utf8.decode(response.bodyBytes);
      return jsonDecode(decodedJson);
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<dynamic> sendFormData(Map<String, String> formData) async {
    final String fullUrl = 'https://app.abz.gl/wp-json/custom/v1/bookings';
    final response = await http.post(
      Uri.parse(fullUrl),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(formData),
    );

    final responseData = jsonDecode(response.body);

    return responseData;
  }

  /// Отмена бронирования (пометка как отменено)
  Future<dynamic> cancelBooking(String bookingId) async {
    final String fullUrl =
        'https://app.abz.gl/wp-json/custom/v1/bookings/cancel';

    print('🔹 Отмена бронирования ID: $bookingId');

    final response = await http.post(
      Uri.parse(fullUrl),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({'booking_id': bookingId}),
    );

    print('🔹 Ответ сервера: ${response.statusCode}');
    print('🔹 Тело ответа: ${response.body}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to cancel booking');
    }
  }
}
