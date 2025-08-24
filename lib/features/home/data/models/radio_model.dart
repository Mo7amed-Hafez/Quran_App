class RadioModel {
  final int id;
  final String name;
  final String url;

  const RadioModel({required this.id, required this.name, required this.url});

  factory RadioModel.fromJson(Map<String, dynamic> json) {
    try {
      return RadioModel(
        id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
        name: json['name']?.toString() ?? '',
        url: json['url']?.toString() ?? '',
      );
    } catch (e) {
      // fallback values في حالة حدوث خطأ
      return const RadioModel(
        id: 0,
        name: 'غير معروف',
        url: '',
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'url': url};
  }

  @override
  String toString() {
    return 'RadioModel(id: $id, name: $name, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RadioModel &&
        other.id == id &&
        other.name == name &&
        other.url == url;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ url.hashCode;
}
