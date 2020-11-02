import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:trapezza/classes/school.dart';
import 'package:flutter/material.dart';

String root = 'http://api.trapezza.kz/api/';

Future<List<School>> fetchSchools(BuildContext context) async {
  final response = await http.get(root + '/schools/');

  if (response.statusCode == 200 ||
      response.statusCode == 201 ||
      response.statusCode == 202) {
    String source = Utf8Decoder().convert(response.bodyBytes);
    var jsonData = jsonDecode(source);
    List schoolsList = jsonData['data'];
    List<School> schools = [];
    for (var school in schoolsList) {
      School s = School(
        id: school['id'],
        title: school['name'],
      );
      schools.add(s);
    }
    return schools;
  } else {
    throw Exception('schools ' + response.statusCode.toString());
  }
}

class Dates {
  final int id;
  Dates({@required this.id});
  Future getData() async {
    http.Response response =
        await http.get(root + '/datesByschool/' + id.toString());
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      String source = Utf8Decoder().convert(response.bodyBytes);
      return jsonDecode(source);
    } else {
      print('dates ' + response.statusCode.toString());
    }
  }
}

//Future<List<Date>> fetchDates(BuildContext context, int id) async {
//  final response = await http.get(root + '/datesByschool/' + id.toString());
//
//  if (response.statusCode == 200 ||
//      response.statusCode == 201 ||
//      response.statusCode == 202) {
//    String source = Utf8Decoder().convert(response.bodyBytes);
//    var jsonData = jsonDecode(source);
//    List datesList = jsonData['data'];
//    List<Date> dates = [];
//    for (var date in datesList) {
//      Date s = Date(
//        id: date['id'],
//        name: date['name'],
//        week: date['week'],
//        date: date['date'],
//        today: date['today'],
//      );
//      dates.add(s);
//    }
//    return dates;
//  } else {
//    throw Exception('schools ' + response.statusCode.toString());
//  }
//}

class Menu {
  final int school;
  final int day;
  Menu({@required this.school, @required this.day});
  Future getData() async {
    http.Response response = await http
        .get(root + '/getmenu/' + school.toString() + '/' + day.toString());
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      String source = Utf8Decoder().convert(response.bodyBytes);
      return jsonDecode(source);
    } else {
      print('menu ' + response.statusCode.toString());
    }
  }
}

class MealGetter {
  final int id;
  MealGetter({@required this.id});
  Future getData() async {
    http.Response response =
        await http.get(root + '/getfoods/' + id.toString());
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      String source = Utf8Decoder().convert(response.bodyBytes);
      return jsonDecode(source);
    } else {
      print('meal ' + response.statusCode.toString());
    }
  }
}

class IngredientsGetter {
  final int id;
  IngredientsGetter({@required this.id});
  Future getData() async {
    http.Response response =
        await http.get(root + '/getIngredient/' + id.toString());
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      String source = Utf8Decoder().convert(response.bodyBytes);
      return jsonDecode(source);
    } else {
      print('ingredient ' + response.statusCode.toString());
    }
  }
}
