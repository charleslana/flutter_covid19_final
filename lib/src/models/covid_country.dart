class CovidCountry {
  final int cases;
  final int deaths;
  final int recovered;
  final int todayCases;
  final int todayDeaths;
  final int todayRecovered;

  CovidCountry({
    required this.cases,
    required this.deaths,
    required this.recovered,
    required this.todayCases,
    required this.todayDeaths,
    required this.todayRecovered,
  });

  factory CovidCountry.fromJson(Map<String, dynamic> json) {
    return CovidCountry(
      cases: json['cases'],
      deaths: json['deaths'],
      recovered: json['recovered'],
      todayCases: json['todayCases'],
      todayDeaths: json['todayDeaths'],
      todayRecovered: json['todayRecovered'],
    );
  }
}
