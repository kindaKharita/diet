import 'package:diet/firebase/allergy.dart';
import 'package:diet/firebase/sport.dart';
import 'package:diet/firebase/user.dart';
import 'package:diet/provider/app_filtter_list_provider.dart';
import 'package:diet/recommendation/recommend.dart';
import 'package:diet/utils/app_name_list_food.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/meteocons_icons.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class  AppFunction{
  void initSharedPrefernce()async{
    await sharedPreferences!.setString('email', ' ');
    await sharedPreferences!.setString('full_name', ' ');
    await sharedPreferences!.setString('gender_id', '0');
    await sharedPreferences!.setString('height', '0');
    await sharedPreferences!.setString('weight', '0.0');
    await sharedPreferences!.setString('plan_date', '0');
    await sharedPreferences!.setString('age', '0');
    await sharedPreferences!.setString('activity_lvl', '0');
    await sharedPreferences!.setStringList('favourite', []);
    await sharedPreferences!.setStringList('food_allergy', []);
    await sharedPreferences!.setStringList('disease', []);
    await sharedPreferences!.setStringList(NameListFood.breakfast, []);
    await sharedPreferences!.setStringList(NameListFood.lunch, []);
    await sharedPreferences!.setStringList(NameListFood.dinner, []);
    await sharedPreferences!.setStringList(NameListFood.snack, []);
    await sharedPreferences!.setStringList(NameListFood.appetizers, []);
    await sharedPreferences!.setDouble('sport-cal', 0.0);
    await sharedPreferences!.setStringList('sport', []);
    sharedPreferences!.setDouble('curr-cal',0);
    sharedPreferences!.setStringList('dishType',[]);
  }


  void setSharedPrefernce(List list)async{
  //  myUserApp!.email=list.first['email'];
  //   myUserApp = Users('id',
  //       list.first['full_name'],
  //       list.first['age'],
  //       list.first['gender_id'],
  //       list.first['height'],
  //       list.first['weight'],
  //       list.first['activity_lvl'],
  //       list.first['email']);

    await sharedPreferences!.setString('email',list.first['email']);
    await sharedPreferences!.setString('full_name',list.first['full_name']);
    await sharedPreferences!.setString('gender_id', list.first['gender_id'].toString());
    await sharedPreferences!.setString('height', list.first['height'].toString());
    await sharedPreferences!.setString('weight', list.first['weight'].toString());
    await sharedPreferences!.setString('plan_date', list.first['plan_date'].toString());
    await sharedPreferences!.setString('age', list.first['age'].toString());

    await sharedPreferences!.setString('activity_lvl', list.first['activity_lvl'].toString());

    await sharedPreferences!.setStringList(
        'favourite', convertDynamicToString(list.first['favourite']));
    // print(list.first['food_allergy'].toString()+'qwwqwq');
    await sharedPreferences!.setStringList('food_allergy', convertDynamicToString(list.first['food_allergy']));
    // print(list.first['disease']);
    await sharedPreferences!.setStringList('disease', convertDynamicToString(list.first['disease']));
    // print(convertDynamicToString(list.first['favourite']));
  }
  List<String> convertDynamicToString(list){
    List<String> listString=<String>[];
    List<dynamic> temp=list;
    for(int i=0 ;i<temp.length;i++){
      listString.add(temp[i]);
    }
    return listString;
  }

  void initBeforAllergyList(BuildContext context)  {
    Allergy allergy = Allergy(food: '', allergy: '');
    listFoodAfterFilterAllergy=allergy.getFilteredData();
    // try {
    //   listFoodAfterFilterAllergy= await Provider.of<AppProvider>(context,
    //       listen: false).allFoodAftterFiltterlAllergyList();
    // }catch(e){
    //   print("error");
    //   print(e);
    // }
  }

  Future<void> initSportList() async {
    Sport sport =  Sport('', null);

    var temp= await sport.getAllSports();
    sport.calAllForWeight(myUserApp!.weight, temp);
    allSports =temp;
    // print(myUserApp!.weight.toString());


  }

  Future<void> initListAllFood(BuildContext context) async {

    try {
      allFoods= await Provider.of<AppProvider>(context,
          listen: false).allFoodBeforFiltterlAllergyList();
    }catch(e){
      print("error");
      print(e);
    }
  }

  Future<void> initAllergyList(BuildContext context) async {
    // List allergy=[];
    try {
      listAllergy= await Provider.of<AppProvider>(context,
          listen: false).allAllergyList();
    }catch(e){
      print("error");
      print(e);
    }
    // return allergy;
  }
  Future<void> fetchRecFood()async {
    Recommend rec = Recommend();
    var fetchedFood =await rec.fetch();
    allRecFoods=fetchedFood;
  }

 Users? getAllInfoUsre()  {
    String?name=sharedPreferences!.getString('full_name');
    // String ?password=sharedPreferences!.getString('pass');
    String? temp=sharedPreferences!.getString('age');
    int? age=int.tryParse(temp!);
    String? gender=sharedPreferences!.getString('gender_id');
    int? gender_id=int.tryParse(gender!);
    temp=sharedPreferences!.getString('height');
    num? height=num.tryParse(temp!);
    temp=sharedPreferences!.getString('weight');
    double ?weight=double.tryParse(temp!);

    // rayan
    temp = sharedPreferences!.getString('activity_lvl');
    int? activity_lvl = int.tryParse(temp!);

    String? email =sharedPreferences!.getString('email');
    List<String> favorite=sharedPreferences!.getStringList('favourite')!;
    List<String> food_allergy=sharedPreferences!.getStringList('food_allergy')!;
    List<String> disease=sharedPreferences!.getStringList('disease')!;
    print(height);
    temp = sharedPreferences!.getString('plan_date');
    int? plan_date = int.tryParse(temp!);
    myUserApp =Users('id', name!, age!, gender_id!, height!, weight!, activity_lvl!,email!);
    myUserApp!.disease=disease;
    myUserApp!.food_allergy=food_allergy;
    myUserApp!.favourite=favorite;
    myUserApp!.curr_calories= sharedPreferences!
        .getDouble('curr-cal')!;
    myUserApp!.plan_date=plan_date;
    myUserApp!.sport_calories= sharedPreferences!
        .getDouble('sport-cal')!;
    myUserApp!.getCaloriesChange();



     sharedPreferences!.setString('bmiState', myUserApp!.getBmiStates());
     sharedPreferences!.setDouble('cal', myUserApp!.calories);
     print(myUserApp!.calories);
    print(myUserApp!.height);
    print(myUserApp!.weight);

    return myUserApp;

  }



}