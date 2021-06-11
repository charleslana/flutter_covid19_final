class CovidVaccine {
  final List list;

  CovidVaccine({
    required this.list,
  });

  factory CovidVaccine.fromJson(List<dynamic> json) {
    return CovidVaccine(
      list: json,
    );
  }
}
