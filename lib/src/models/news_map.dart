class NewsMap {
  final Map map;

  NewsMap({
    required this.map,
  });

  factory NewsMap.fromJson(Map<String, dynamic> json) {
    return NewsMap(
      map: json,
    );
  }
}
