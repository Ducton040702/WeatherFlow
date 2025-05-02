import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const apiKey = '65606f92ae7a3f2527ee4213d4ec03e1';

  static Future<Map<String, dynamic>> fetchWeather(String city) async {
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=imperial';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
