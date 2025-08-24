class SurahModel {
  final int id;
  final String name;
   final int makkia;

  SurahModel({required this.id, required this.name, required this.makkia});

  factory SurahModel.fromJson(Map<dynamic, dynamic> json) {
    return SurahModel(
      id: json['id'],
      name: json['name'],
      makkia: json['makkia'],
    );
  }
}
