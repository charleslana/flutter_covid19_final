import 'dart:convert';
import 'package:flutter_covid19_final/src/models/covid_country.dart';
import 'package:flutter_covid19_final/src/models/covid_history.dart';
import 'package:flutter_covid19_final/src/models/covid_vaccine.dart';
import 'package:flutter_covid19_final/src/models/covid_world_wide.dart';
import 'package:http/http.dart' as http;

class ApiCovid {
  static const _baseUrl = 'https://disease.sh/v3/covid-19';

  Future<CovidHistory> fetchCovidHistory() async {
    final response =
        await http.get(Uri.parse('$_baseUrl/historical/all?lastdays=90'));

    if (response.statusCode == 200) {
      return CovidHistory.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<CovidWorldWide> fetchCovidWorldWide() async {
    final response = await http.get(Uri.parse('$_baseUrl/all'));

    if (response.statusCode == 200) {
      return CovidWorldWide.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<CovidCountry> fetchCovidByCountry(String country) async {
    final response = await http.get(Uri.parse('$_baseUrl/countries/$country'));

    if (response.statusCode == 200) {
      return CovidCountry.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<CovidVaccine> fetchCovidVaccine() async {
    final response = await http
        .get(Uri.parse('$_baseUrl/vaccine/coverage/countries?lastdays=1'));

    if (response.statusCode == 200) {
      return CovidVaccine.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
