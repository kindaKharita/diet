import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet/firebase/disease.dart';
import 'package:diet/firebase/foods.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';

import '../main.dart';

// ignore: must_be_immutable
class Allergy extends StatelessWidget {
  //final DocumentSnapshot documentSnapshot;
  String food;
  String allergy;

  //List<Allergy> loadedList = [];

  Allergy({
    required this.food,
    required this.allergy,
  });

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }

  // final CollectionReference _collectionFoods =
  // FirebaseFirestore.instance.collection('foods');

  final CollectionReference _collectionAlg =
  FirebaseFirestore.instance.collection('allergies');

  Future<List> getAllAllergies() async {
    QuerySnapshot querySnapshot = await _collectionAlg.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    return allData;
  }

  List getFilteredData() {
    Foods foo = Foods(
      title: '',
      image: '',
      vegetarian: false,
      alcohol_g: 0,
      potassium_mg: 0,
      calories: 0,
      dishTypes: [],
      ingredients: [],
    );
    Disease disObj = Disease();
    List<String> foodAllergy =
    sharedPreferences!.getStringList("food_allergy")!;
    List<String> disease = sharedPreferences!.getStringList("disease")!;
    // print(foodAllergy);
    List<dynamic> res = <dynamic>[];
    if (foodAllergy.isNotEmpty) {
      for (int i = 0; i < allFoods!.length; i++) {
        bool ok = false;
        for (int j = 0; j < foodAllergy.length; j++) {
          if (isFound(allFoods![i]['ingredients'], foodAllergy[j])) {
            ok = true;
            break;
          }
        }
        if (!ok) {
          res.add(allFoods![i]);
        }
      }
      // return res;
    } else {
      res = allFoods!;
    }
    print('74 allergy');
    print(allFoods!.length.toString()+'\t all foods');
    print(res.length.toString()+'\t after alg');

    if (disease.isNotEmpty) {
      if (disease.contains('Non Alcoholic')) {
        res = foo.filterNoAlcohol(res);
        // print(res.length.toString()+'\t after alcohol');
      }
      if (disease.contains('Vegetarian')) {
        // res = foo.filterVegetarian(res);
      }
      // print(res.length.toString()+'\t after Vege');
      if(disease.contains('Pressure Disease')||disease.contains('Heart Disease')) {
        res = disObj.heartDisFilter(res);
      }
      print(res[4]['title'].toString()+'\t after pre');
      print(res[5]['title'].toString()+'\t after pre');
      if(disease.contains('Diabetes')){
        print(myUserApp!.calories.toString() + '  92 allergy');
        disObj.editUserCal();
        print(myUserApp!.calories);
        res=disObj.diabetesFilterFood(res);
      }
      print(res[4]['title'].toString()+'\t after dia');
      print(res[5]['title'].toString()+'\t after dia');
    }
    return res;
    // return allFoods!;

    // print("size before allergy filter:" + '${foodAllergy.length}');
  }

  bool isFound(List list, String ingredient) {
    for (int i = 0; i < list.length; i++) {
      if (list[i].toString().toLowerCase().contains(ingredient.toLowerCase()))
        return true;
    }
    return false;
  }
}
