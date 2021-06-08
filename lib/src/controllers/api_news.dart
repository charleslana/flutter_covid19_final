import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiNews {
  static const _baseUrl =
      'https://flutterbirds-covid19-default-rtdb.firebaseio.com/';

  Map<Object, dynamic> _items = {};

  Future<dynamic> getByType(String type) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/news.json'),
      );

      if (response.statusCode != 200) {
        return null;
      }

      final data = json.decode(response.body);

      if (data != null) {
        data.forEach((key, value) {
          if (value['type'] == type) {
            _items.putIfAbsent(
              key as String,
              () => {
                'id': key,
                'title': value['title'],
                'message': value['message'],
                'urlImage': value['urlImage'],
                'source': value['source'],
                'type': value['type'],
              },
            );
          }
        });
        sort();
        return _items;
      }
    } catch (e) {
      return null;
    }
  }

  void sort() {
    final Map<String, dynamic> data = new SplayTreeMap<String, dynamic>.from(
        _items, (a, b) => b.compareTo(a));
    _items = data;
  }
}
