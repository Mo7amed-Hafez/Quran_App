class SuwarPageModel {
  final String page; // اسم ملف الصفحة مثل "002.svg" أو رابط كامل
  final int? id;
  final String? time;

  const SuwarPageModel({required this.page, this.id, this.time});

  factory SuwarPageModel.fromJson(Map<String, dynamic> json) {
    // نحاول نقرأ الحقل بعدة أسماء ممكن الـ API يرجعه بيها
    String? pageValue;
    if (json.containsKey('page')) {
      pageValue = json['page']?.toString();
    } else if (json.containsKey('file')) {
      pageValue = json['file']?.toString();
    } else if (json.containsKey('page_name')) {
      pageValue = json['page_name']?.toString();
    } else if (json.containsKey('image')) {
      pageValue = json['image']?.toString();
    }

    // لو مفيش page ممكن نحاول نركبه من id (مثلاً id=2 -> 002.svg)
    if ((pageValue == null || pageValue.isEmpty) && json.containsKey('id')) {
      final dynamic rawId = json['id'];
      final int? idParsed = int.tryParse(rawId.toString());
      if (idParsed != null) {
        pageValue = idParsed.toString().padLeft(3, '0') + '.svg';
      }
    }

    // fallback آمن
    pageValue ??= '001.svg';

    final int? idValue = json['id'] != null
        ? int.tryParse(json['id'].toString())
        : null;

    return SuwarPageModel(
      page: pageValue,
      id: idValue,
      time: json['time']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'page': page, 'id': id, 'time': time};
  }

  @override
  String toString() {
    return 'SuwarPageModel(page: $page, id: $id, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SuwarPageModel &&
        other.page == page &&
        other.id == id &&
        other.time == time;
  }

  @override
  int get hashCode => page.hashCode ^ id.hashCode ^ time.hashCode;
}
