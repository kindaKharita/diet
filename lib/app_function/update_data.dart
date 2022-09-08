import 'package:diet/main.dart';
import 'package:flutter/material.dart';

class UpdateData{

  void updateName(name ){
    if(name.toString().isNotEmpty){
      myUserApp!.name=name;
    }
    myUserApp!.update(myUserApp!.email);
    sharedPreferences!.setString('full_name', myUserApp!.name);
  }

  void updateAge(age){
    if(age.toString().isNotEmpty){
      myUserApp!.age=int.tryParse(age)!;
    }
    myUserApp!.update(myUserApp!.email);
    sharedPreferences!.setString('age', myUserApp!.age.toString());
  }

  void updateWeight(weight){
    if(weight.toString().isNotEmpty){
      myUserApp!.weight=double.tryParse(weight)!;
    }
    myUserApp!.update(myUserApp!.email);
    sharedPreferences!.setString('weight', myUserApp!.weight.toString());
  }

  void updateLength(length){
    if(length.toString().isNotEmpty){
      myUserApp!.height=double.tryParse(length)!;
    }
    myUserApp!.update(myUserApp!.email);
    sharedPreferences!.setString('height', myUserApp!.height.toString());
  }

}