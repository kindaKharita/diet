import 'dart:core';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Sport {
  String activity_h;
  var calories_kg;

  Sport(this.activity_h, this.calories_kg);

  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('sports');

  Future<List> getAllSports() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    return allData;
  }

  void calAllForWeight(var weight, List allSports) {
    for (int i = 0; i < allSports.length; i++) {
      allSports[i]['calories_kg'] = allSports[i]['calories_kg']! * weight;
    }
  }

  ///operations : max - min
  List<dynamic> filterCalories(String operation, var calories, List allSports) {
    List<dynamic> res = <dynamic>[];
    if (operation == 'max') {
      for (int i = 0; i < allSports.length; i++) {
        if (allSports[i]['calories_kg'] >= calories) res.add(allSports[i]);
      }
      if (res.isEmpty) res.add(allSports.first);
      return res;
    } else if (operation == 'min') {
      for (int i = 0; i < allSports.length; i++) {
        if (allSports[i]['calories_kg'] <= calories) res.add(allSports[i]);
      }
      if (res.isEmpty) res.add(allSports.first);
      return res;
    } else
      return allSports;
  }
}
