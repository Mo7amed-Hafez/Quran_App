class RadioModel {
  final int id;
  final String name;
  final String url;
  final String ? date;

  RadioModel({
    required this.id,
    required this.name,
    required this.url,
    this.date,
  });

  factory RadioModel.fromJson(Map<dynamic, dynamic> json) {
    return RadioModel(
      id: json['id'],
      name: json['name'],
      url: json['url'],
      date: json['date'] ?? "undefined",
    );
  }
}
