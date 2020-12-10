class Panchang {
  String web;
  String name;
  String thumbnailUrl;
  Panchang({this.web, this.name, this.thumbnailUrl});
  // Return object from JSON //
  factory Panchang.fromJson(Map<String, dynamic> json) {
    return Panchang(
        web: json['web'] as String,
        name: json['name'] as String,
        thumbnailUrl: json['image'] as String);
  }
}
