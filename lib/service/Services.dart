import 'dart:convert';
import 'package:dharmlok/model/model.dart';
import 'package:flutter/services.dart' show rootBundle;
class Services {
  static Future<List<Model>> getJson() async {
    try {
      final response = await rootBundle.loadString('assets/dharmlok.json');
      List<Model> list = parseData(response);
      return list;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  static List<Model> parseData(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Model>((json) => Model.fromJson(json)).toList();
  }
}
