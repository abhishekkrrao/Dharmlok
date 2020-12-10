class HomeModel {
  String web;
  String name;
  String thumbnailUrl;
  HomeModel({this.web, this.name, this.thumbnailUrl});
  // Return object from JSON //
  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
        web: json['webUrl'] as String,
        name: json['name'] as String,
        thumbnailUrl: json['photo'] as String);
  }
}
