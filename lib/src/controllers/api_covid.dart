import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_covid19_final/src/utils/format_number.dart';
import 'package:http/http.dart' as http;

class ApiCovid {
  static const _baseUrl = 'https://disease.sh/v3/covid-19';

  final formatNumber = new FormatNumber();

  late String casesAll;
  late String deathsAll;
  late String recoveredAll;

  late List<FlSpot> casesGlobal = [];
  late List<FlSpot> deathsGlobal = [];
  late List<FlSpot> recoveredGlobal = [];

  late String vaccines;

  Future<dynamic> getDataWorldWide() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/all'));

      if (response.statusCode != 200) {
        return null;
      }

      final data = json.decode(response.body);

      casesAll = formatNumber.get(data['cases']);
      deathsAll = formatNumber.get(data['deaths']);
      recoveredAll = formatNumber.get(data['recovered']);

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
      final response =
          await http.get(Uri.parse('$_baseUrl/historical/all?lastdays=90'));

      if (response.statusCode != 200) {
        return null;
      }

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
      final response = await http.get(Uri.parse('$_baseUrl/countries/brazil'));

      if (response.statusCode != 200) {
        return null;
      }

      final data = json.decode(response.body);

      return [
        formatNumber.get(data['cases']),
        formatNumber.get(data['deaths']),
        formatNumber.get(data['recovered']),
        formatNumber.get(data['todayCases']),
        formatNumber.get(data['todayDeaths']),
        formatNumber.get(data['todayRecovered']),
      ];
    } catch (error) {
      return null;
    }
  }

  Future<dynamic> getDataVaccine() async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/vaccine/coverage/countries?lastdays=1'));

      if (response.statusCode != 200) {
        return null;
      }

      final data = json.decode(response.body);

      Map<String, dynamic> dataVaccinesBrazil = data[27]['timeline'];

      dataVaccinesBrazil.forEach((key, value) {
        vaccines = formatNumber.get(value);
      });

      return vaccines;
    } catch (error) {
      return null;
    }
  }
}
