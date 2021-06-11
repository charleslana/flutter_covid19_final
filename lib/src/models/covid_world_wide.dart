class CovidWorldWide {
  final int cases;
  final int deaths;
  final int recovered;

  CovidWorldWide({
    required this.cases,
    required this.deaths,
    required this.recovered,
  });

  factory CovidWorldWide.fromJson(Map<String, dynamic> json) {
    return CovidWorldWide(
      cases: json['cases'],
      deaths: json['deaths'],
      recovered: json['recovered'],
    );
  }
}
