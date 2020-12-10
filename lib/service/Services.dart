import 'dart:convert';
import 'package:dharmlok/model/HomeModel.dart';
import 'package:dharmlok/model/model.dart';
import 'package:dharmlok/model/panchang.dart';
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
  static Future<List<HomeModel>> getHomeJson() async {
    try {
      final response = await rootBundle.loadString('assets/home.json');
      List<HomeModel> list = parseHomeData(response);
      return list;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  static List<HomeModel> parseHomeData(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<HomeModel>((json) => HomeModel.fromJson(json)).toList();
  }
  static Future<List<Panchang>> getPanchangJson() async {
    try {
      final response = await rootBundle.loadString('assets/panchang.json');
      List<Panchang> list = parsePanchangData(response);
      return list;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  static List<Panchang> parsePanchangData(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Panchang>((json) => Panchang.fromJson(json)).toList();
  }

  static List<Model> parseData(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Model>((json) => Model.fromJson(json)).toList();
  }
}
