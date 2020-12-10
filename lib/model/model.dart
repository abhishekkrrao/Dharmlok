class Model {
  String web;
  String name;
  String desc;
  String thumbnailUrl;
  String color;

  Model({this.web, this.name, this.thumbnailUrl, this.desc, this.color});

  // Return object from JSON //
  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
        web: json['web'] as String,
        name: json['name'] as String,
        desc: json['desc'] as String,
        thumbnailUrl: json['image'] as String,
        color: json['color'] as String);
  }
}
