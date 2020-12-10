class EventModel {
  String web;
  String name;
  String thumbnailUrl;
  EventModel({this.web, this.name, this.thumbnailUrl});
  // Return object from JSON //
  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
        web: json['web'] as String,
        name: json['name'] as String,
        thumbnailUrl: json['image'] as String);
  }
}