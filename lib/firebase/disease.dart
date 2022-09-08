import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet/firebase/foods.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';

import '../main.dart';

class Disease {
  Foods food = Foods(
    title: '',
    image: '',
    vegetarian: false,
    alcohol_g: 0,
    potassium_mg: 0,
    calories: 0,
    dishTypes: [],
    ingredients: [],
  );

  void editUserCal(){
    if(myUserApp!.age<12){
      if(myUserApp!.genderId==0)
        myUserApp!.calories=(125.0*myUserApp!.age)+100;
      else
        myUserApp!.calories=(100.0*myUserApp!.age)+100;
    }
    else if(myUserApp!.age>=12&&myUserApp!.age<22){
      if(myUserApp!.genderId==0)
        myUserApp!.calories=(myUserApp!.calories+2800)/2.0;
      else
        myUserApp!.calories=(myUserApp!.calories+2200)/2.0;
    }
    else{
      if(myUserApp!.activity_lvl>2){
        if(myUserApp!.genderId==0)
          myUserApp!.calories=(myUserApp!.calories+2500)/2.0;

        else
          myUserApp!.calories=(myUserApp!.calories+1800)/2.0;
      }
    }
  }
  List<dynamic> diabetesFilterFood(List allData){
    food.sortBy(allData, 'health_score');
    food.sortBy(allData, 'carbohydrates_g');
    food.sortBy(allData, 'per_carbs');
    var res = new List<dynamic>.from(allData.reversed);
    return res;
  }

  List<dynamic> heartDisFilter(List allData){
    food.sortBy(allData, 'health_score');
    var res = new List<dynamic>.from(allData.reversed);
    food.sortBy(res, 'cholesterol_mg');
    food.sortBy(res, 'per_fat');
    return res;
  }
}

