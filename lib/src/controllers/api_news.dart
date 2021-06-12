import 'dart:convert';
import 'package:flutter_covid19_final/src/models/news_map.dart';
import 'package:http/http.dart' as http;

class ApiNews {
  static const _baseUrl =
      'https://flutterbirds-covid19-default-rtdb.firebaseio.com';

  Future<NewsMap> fetchAll() async {
    final response = await http.get(Uri.parse('$_baseUrl/news.json'));

    if (response.statusCode == 200) {
      return NewsMap.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
