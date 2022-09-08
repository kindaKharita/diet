import 'dart:core';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class Foods extends StatelessWidget {
  //final DocumentSnapshot documentSnapshot;
  String? title;
  List? ingredients;
  var calories;
  String? image;
  List? dishTypes;
  var alcohol_g;
  var potassium_mg;
  bool? vegetarian;

  var per_protein;
  var per_fat;
  var per_carbs;
  var carbohydrates_g;
  var cholesterol_mg;
  var vit_c_mg;
  var protein_g;
  var health_score;

  // ignore: use_key_in_widget_constructors
  Foods({
    this.title,
    this.ingredients,
    this.calories,
    this.image,
    this.dishTypes,
    // ignore: non_constant_identifier_names
    this.alcohol_g,
    // ignore: non_constant_identifier_names
    this.potassium_mg,
    this.vegetarian,
    this.per_protein,
    this.per_fat,
    this.per_carbs,
    this.carbohydrates_g,
    this.cholesterol_mg,
    this.vit_c_mg,
    this.protein_g,
    this.health_score,
  });

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }

  final CollectionReference _collectionRef =
  FirebaseFirestore.instance.collection('foods');



  Future<void> addFood() {
    return _collectionRef
        .add({
      'title':this.title,
      'ingredients':this.ingredients,
      'calories':this.calories,
      'image':this.image,
      'dishTypes':this.dishTypes,
      'alcohol_g':this.alcohol_g,
      'potassium_mg':this.potassium_mg,
      'vegetarian':this.vegetarian,
      'per_protein':this.per_protein,
      'per_fat':this.per_fat,
      'per_carbs':this.per_carbs,
      'carbohydrates_g':this.carbohydrates_g,
      'cholesterol_mg':this.cholesterol_mg,
      'vit_c_mg':this.vit_c_mg,
      'protein_g':this.protein_g,
      'health_score':this.health_score,
    })
        .then((value) => print("Food Added"))
        .catchError((error) => print("Failed to add food: $error"));
  }




  Future<List> getAllFoods() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    return allData;
  }

  ///parameters: allergies list and calories to filter on
  List<dynamic> filterCalories(List<dynamic> allData, var calories) {
    List<dynamic> res = <dynamic>[];

    for (int i = 0; i < allData.length; i++) {
      var temp = allData[i]['calories'];
      if (temp! <= calories) res.add(allData[i]);
    }
    return res;
  }

  ///dishTypes: lunch ; dinner ; breakfast ; snack ; appetizers
  List<dynamic> filterDishTypes(List<dynamic> allData, var dishType) {
    List<dynamic> res = <dynamic>[];
    for (int i = 0; i < allData.length; i++) {
      List<dynamic> temp = <dynamic>[];
      temp = allData[i]['dishTypes'];
      temp.forEach((type) {
        if (type == dishType) res.add(allData[i]);
      });
    }
    return res;
  }

  List<dynamic> filterNoAlcohol(List<dynamic> allData) {
    List<dynamic> res = <dynamic>[];
    for (int i = 0; i < allData.length; i++) {
      if (allData[i]['alcohol_g'] > 0) {
        continue;
      }
      res.add(allData[i]);
    }
    return res;
  }

  List<dynamic> filterVegetarian(List<dynamic> allData) {
    List<dynamic> res = <dynamic>[];
    for (int i = 0; i < allData.length; i++) {
      if (!allData[i]['vegetarian']) {
        continue;
      }
      res.add(allData[i]);
    }
    return res;
  }

  ///to get all foods with large or little amount of ingredients
  void sortBy(List<dynamic> allData, var flag) {
    allData.sort((a, b) => a[flag]!.compareTo(b[flag]));
  }


  List<dynamic> limit(
      List<dynamic> allData, String flag, String operation, var limitation) {
    List<dynamic> res = <dynamic>[];
    for (int i = 0; i < allData.length; i++) {
      if (operation == 'max') {
        if (allData[i][flag]! < limitation) continue;
        res.add(allData[i]);
      } else if (operation == 'min') {
        if (allData[i][flag]! > limitation) continue;
        res.add(allData[i]);
      } else
        return allData;
    }
    return res;
  }
}
