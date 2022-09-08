import 'dart:convert';

import 'package:diet/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Recommend {
  //TODO add permission :  <uses-permission android:name="android.permission.INTERNET" />
  //todo edit gradle.pro
  Recommend();

  http.Client getClient() {
    return http.Client();
  }

  Future<List> fetch() async {
    var temp = sharedPreferences!.getStringList('favourite');
    if(temp!.isEmpty)
      return allFoods!;

    String res = '';
    for (int i = 0; i < temp.length; i++) {
      if (i == temp.length - 1) {
        res += temp[i];
      } else
        res += temp[i] + '#';
    }
    print(res);

    var client = getClient();

    //{'title': res,}

    final foods =
        await client.post(Uri.parse('http://192.168.43.254:8000/'), body: {
      'title': res,
    });
    //jsonEncode(<String, String>
    //  if (foods.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    Map<String, dynamic> map = jsonDecode(foods.body);
  //  print(map);
    // print(foods.statusCode.toString() + 'wla');
    List<dynamic> foodRec = getFoodFromTitle(map['title']);
    print(foodRec.length);
    if (foodRec.isEmpty) foodRec = allFoods!;
    return foodRec;
    //} else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to connect');
    //}
    // ..then((foods) {
    //   Map<String, dynamic> map = jsonDecode(foods.body);
    //   print(map);
    //   print(foods.statusCode.toString()+'wla');
    //   var temp = getFoodFromTitle(map['title']);
    //   if (temp.isEmpty) temp = allFoods!;
    //   return temp;
    // });
    //  return allFoods!;
  }

  // List<dynamic> getRecFoods() {
  //   fetch()
  //     ..then((foods) {
  //       Map<String, dynamic> map = jsonDecode(foods.body);
  //       print(map);
  //       return getFoodFromTitle(map['title']);
  //     });
  //   return allFoods!;
  // }

  List<dynamic> getFoodFromTitle(List<dynamic> res) {
    List<dynamic> allData = <dynamic>[];
    for (int i = 0; i < allFoods!.length; i++) {
      if (res.contains(allFoods![i]['title'].toString())) {
        allData.add(allFoods![i]);
      }
    }
    // print(allData);
    return allData;
  }
}
