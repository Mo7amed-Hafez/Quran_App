class SuwarPageModel {
  final String pageUrl;

  SuwarPageModel({required this.pageUrl});

  factory SuwarPageModel.fromJson(Map<String, dynamic> json){
    return SuwarPageModel(pageUrl: json['page']);
  }
}
