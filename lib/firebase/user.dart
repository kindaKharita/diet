import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet/firebase/allergy.dart';
import 'package:diet/main.dart';
import 'package:flutter/cupertino.dart';

class Users {
  String id;
  String name;
  int age;
  int genderId;
  num height;
  double weight;
  int activity_lvl;
  double calories = 0;
  double sport_calories = 0;

  double curr_calories = 0;

  ///new attributes
  String email;

  List<String> allergies = <String>[];
  List<String> favourite = <String>[];
  int ?plan_date=0 ;
  List<String> food_allergy = <String>[];
  List<String> disease = <String>[];

  Users(
      this.id,
      this.name,
      this.age,
      this.genderId, //1:male ; 2:female
      this.height,
      this.weight,
      //this.calories,
      //this.curr_calories,
      this.activity_lvl,
      this.email
      //this.allergies
      );

  CollectionReference _user = FirebaseFirestore.instance.collection('users');

  Future<void> update(String email) async {
    QuerySnapshot temp = await _user.where('email', isEqualTo: email).get();
    String id = temp.docs[0].id;
    _user
        .doc(id)
        .update({
          'full_name': this.name,
          'age': this.age,
          'gender_id': this.genderId,
          'height': this.height,
          'weight': this.weight,
          'favourite': this.favourite,
          'plan_date': this.plan_date,
          'food_allergy': this.food_allergy,
          'activity_lvl': this.activity_lvl,
          'disease': this.disease,
        })
        .then((_) => print('Success update'))
        .catchError((error) => print('Failed: $error'));
  }

  Future<void> addUser() {
    return _user
        .add({
          'full_name': this.name,
          'age': this.age,
          'email': this.email,
          'gender_id': this.genderId,
          'height': this.height,
          'weight': this.weight,
          'favourite': this.favourite,
          'plan_date': this.plan_date,
          'food_allergy': this.food_allergy,
          'activity_lvl': this.activity_lvl,
          'disease': this.disease,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<List> getUser(String email) async {
    QuerySnapshot querySnapshot;
    querySnapshot = await _user.where('email', isEqualTo: email).get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    return allData;
  }



  void getCaloriesChange() {
    /// 		 -ve calories means less calorie intake (lose weight)
    /// 		 +ve calories means more calorie intake (gain weight)
    double calDiff;
    double calBase = this.getDailyCal();
    double bmi = this.getBmi();
    if (bmi < 18.5)
      calDiff = 500;
    else if (bmi >= 18.5 && bmi < 25.0)
      calDiff = 300;
    else if (bmi >= 25.0 && bmi < 30.0)
      calDiff = -300;
    else if (bmi >= 30.0) ;
    calDiff = -500;
    this.calories = calBase + calDiff;

    this.calories = double.tryParse(this.calories.toStringAsFixed(3))!;
  }

  bool checkFood(double foodCal) {
    if ((this.curr_calories + foodCal) > (this.calories + 214.0))
      return false;
    else {
//      this.curr_calories += foodCal;
      return true;
    }
  }

  bool checkSport(double sportCal) {
    if ((this.sport_calories + sportCal) > 214.0)
      return false;
    else {
      // sharedPreferences!.setDouble('sport-cal', allCal+sportCal);
      return true;
    }
  }

  String checkCompletePlan() {

    if (this.curr_calories < this.calories / 50.0) return "You need to add some foods to complete calories allotments";
    if (this.sport_calories < this.curr_calories - (this.calories)) return "You need to add some exercises";

    return "plan Completed";
  }

  ///for me Page
  double percent() {
    double res;
    myUserApp!.getCaloriesChange();
    double foodCal;
    double sportCal;
    try {
      foodCal = sharedPreferences!.getDouble('curr-cal')!;
      sportCal = sharedPreferences!.getDouble('sport-cal')!;
    } catch (e) {
      return 100;
    }
    // double foodCal = this.curr_calories;
    // double sportCal = this.sport_calories;
    if (sportCal > foodCal) return 100;
    res = (foodCal - sportCal) / this.calories * 100;
    if (res > 100) return 100;
    return res;
  }

  double getBmi() {
    double temp = this.height / 100;
    return this.weight / (temp * temp);
  }

  double getBmr() {
    ///male
    if (this.genderId == 1) {
      double temp =
          66 + (13.7 * this.weight) + (5.0 * this.height) - (6.8 * this.age);
      return temp;

      ///female
    } else if (this.genderId == 2) {
      double temp =
          66 + (13.7 * this.weight) + (5.0 * this.height) - (6.8 * this.age);
      return temp;
    } else
      return 0;
  }

  double getDailyCal() {
    /// Calculate total calories per day based on the activity_level selected
    /// Each activity level has specific activity factor for calories calculation
    double bmr = this.getBmr();
    if (activity_lvl == 1)
      return bmr * 1.2;
    else if (activity_lvl == 2)
      return bmr * 1.375;
    else if (activity_lvl == 3)
      return bmr * 1.55;
    else if (activity_lvl == 4)
      return bmr * 1.725;
    else if (activity_lvl == 5)
      return bmr * 1.9;
    else
      return 0;
  }

  String getBmiStates() {
    double bmi = this.getBmi();
    if (bmi < 18.5)
      return 'underWeight';
    else if (bmi >= 18.5 && bmi < 25.0)
      return 'normal';
    else if (bmi >= 25.0 && bmi < 30.0)
      return 'overWeight';
    else
      return 'obese';
  }
}
