class SurahModel {
  final int id;
  final String name;
  final int makkia;

  const SurahModel({
    required this.id,
    required this.name,
    required this.makkia,
  });

  factory SurahModel.fromJson(Map<String, dynamic> json) {
    try {
      return SurahModel(
        id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
        name: json['name']?.toString() ?? '',
        makkia: json['makkia'] is int ? json['makkia'] : int.tryParse(json['makkia'].toString()) ?? 0,
      );
    } catch (e) {
      // fallback values في حالة حدوث خطأ
      return const SurahModel(
        id: 0,
        name: 'غير معروف',
        makkia: 0,
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'makkia': makkia};
  }

  @override
  String toString() {
    return 'SurahModel(id: $id, name: $name, makkia: $makkia)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SurahModel &&
        other.id == id &&
        other.name == name &&
        other.makkia == makkia;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ makkia.hashCode;
}
