class CovidHistory {
  final Map cases;
  final Map deaths;
  final Map recovered;

  CovidHistory({
    required this.cases,
    required this.deaths,
    required this.recovered,
  });

  factory CovidHistory.fromJson(Map<String, dynamic> json) {
    return CovidHistory(
      cases: json['cases'],
      deaths: json['deaths'],
      recovered: json['recovered'],
    );
  }
}
