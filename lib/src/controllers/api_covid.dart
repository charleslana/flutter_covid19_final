import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ApiCovid {
  final urlWorldWide = Uri.parse('https://disease.sh/v3/covid-19/all');
  final urlHistory =
      Uri.parse('https://disease.sh/v3/covid-19/historical/all?lastdays=90');
  final urlCountry =
      Uri.parse('https://disease.sh/v3/covid-19/countries/brazil');

  late String casesAll;
  late String deathsAll;
  late String recoveredAll;

  late List<FlSpot> casesGlobal = [];
  late List<FlSpot> deathsGlobal = [];
  late List<FlSpot> recoveredGlobal = [];

  late String casesBrazil;
  late String deathsBrazil;
  late String recoveredBrazil;
  late String casesTodayBrazil;
  late String deathsTodayBrazil;
  late String recoveredTodayBrazil;

  Future<dynamic> getDataWorldWide() async {
    try {
      final response = await http.get(urlWorldWide);
      final data = json.decode(response.body);

      NumberFormat formatter = NumberFormat('###,000');
      casesAll = formatter.format(data['cases']).replaceAll(',', '.');
      deathsAll = formatter.format(data['deaths']).replaceAll(',', '.');
      recoveredAll = formatter.format(data['recovered']).replaceAll(',', '.');

      return [
        casesAll,
        deathsAll,
        recoveredAll,
      ];
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

      return [
        casesGlobal,
        deathsGlobal,
        recoveredGlobal,
      ];
    } catch (error) {
      return null;
    }
  }

  Future<dynamic> getDataByCountry() async {
    try {
      final response = await http.get(urlCountry);
      final data = json.decode(response.body);

      NumberFormat formatter = NumberFormat('###,000');
      casesBrazil = formatter.format(data['cases']).replaceAll(',', '.');
      deathsBrazil = formatter.format(data['deaths']).replaceAll(',', '.');
      recoveredBrazil =
          formatter.format(data['recovered']).replaceAll(',', '.');

      casesTodayBrazil =
          formatter.format(data['todayCases']).replaceAll(',', '.');
      deathsTodayBrazil =
          formatter.format(data['todayDeaths']).replaceAll(',', '.');
      recoveredTodayBrazil =
          formatter.format(data['todayRecovered']).replaceAll(',', '.');

      return [
        casesBrazil,
        deathsBrazil,
        recoveredBrazil,
        casesTodayBrazil,
        deathsTodayBrazil,
        recoveredTodayBrazil,
      ];
    } catch (error) {
      return null;
    }
  }
}
