import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ApiCovid {
  final urlWorldWide = Uri.parse('https://disease.sh/v3/covid-19/all');
  final urlHistory =
      Uri.parse('https://disease.sh/v3/covid-19/historical/all?lastdays=90');

  late List<FlSpot> casesGlobal = [];
  late List<FlSpot> deathsGlobal = [];
  late List<FlSpot> recoveredGlobal = [];

  Future<String?> getDataWorldWide() async {
    try {
      final response = await http.get(urlWorldWide);
      final data = json.decode(response.body);

      NumberFormat formatter = NumberFormat('###,000');
      return formatter.format(data['cases']).replaceAll(',', '.');
    } catch (error) {
      return null;
    }
  }

  Future<dynamic> getDataHistory() async {
    try {
      final response = await http.get(urlHistory);
      final listCases = json.decode(response.body);

      Map<String, dynamic> dataCases = listCases['cases'];

      late int count = 0;

      dataCases.forEach((key, value) {
        casesGlobal.add(FlSpot(count.toDouble(), value));
        count++;
      });

      Map<String, dynamic> dataDeaths = listCases['deaths'];

      count = 0;

      dataDeaths.forEach((key, value) {
        deathsGlobal.add(FlSpot(count.toDouble(), value));
        count++;
      });

      Map<String, dynamic> dataRecovered = listCases['recovered'];

      count = 0;

      dataRecovered.forEach((key, value) {
        recoveredGlobal.add(FlSpot(count.toDouble(), value));
        count++;
      });

      return [casesGlobal, deathsGlobal, recoveredGlobal];
    } catch (error) {
      return null;
    }
  }
}
