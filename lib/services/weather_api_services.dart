import 'dart:convert';

import 'package:http/http.dart' as http;

import '../exceptions/weather_exception.dart';
import '../models/weather.dart';
import 'http_error_handler.dart';

class WeatherApiServices {
  Future<Weather> getWeather(String city) async {
    final String apiKey =
        'eb818b92507cf7974f9747f9213670da'; // Replace with your actual API key
    final Uri uri = Uri(
      scheme: 'https',
      host: 'api.openweathermap.org',
      path: '/data/2.5/weather',
      queryParameters: {
        'q': city,
        'appid': apiKey,
      },
    );

    try {
      final response = await http.get(uri);
      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      } else {
        final responseBody = json.decode(response.body);

        if (responseBody.isEmpty) {
          throw WeatherException('Cannot get the weather of the city');
        }

        return Weather.fromJson(responseBody);
      }
    } catch (e) {
      rethrow;
    }
  }
}
