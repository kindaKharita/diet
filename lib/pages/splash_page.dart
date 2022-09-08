
import 'dart:async';

import 'package:diet/app_function/app_func.dart';
import 'package:diet/recommendation/recommend.dart';
import 'package:diet/utils/color.dart';
import 'package:diet/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'login_page.dart';

// ignore: use_key_in_widget_constructors
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState()  {

    String? email =sharedPreferences!.getString('email');
    if(email== null) {
      AppFunction().initSharedPrefernce();
      // myUserApp = AppFunction().getAllInfoUsre();
    }
    if(email!=null){
      myUserApp = AppFunction().getAllInfoUsre();
      myUserApp!.getCaloriesChange();
    }

    super.initState();
    try {
      AppFunction().initListAllFood(context);


      // initSharePreferance();

    } catch(e){
      print(e);
    }
    // //TODO init rec food
    // AppFunction().fetchRecFood();
    Timer(const Duration(milliseconds: 6000), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => allFoods==null?SplashPage():isLogIn()? BottomBarPage(2): LoginPage()));
    });
  }



  Future<void> initSharePreferance() async {
    List<String>? list=sharedPreferences!.getStringList('key');
    if(list==null){
      await sharedPreferences!.setStringList(
      'allergyList', []);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white, Colors.white],
                end: Alignment.bottomCenter,
                begin: Alignment.topCenter),
            borderRadius:  BorderRadius.only(
                bottomLeft: Radius.circular(100))),
        child:Column(
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(100)),
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.7,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100)),
                    color: Colors.white,
                  ),
                  child: Image.asset("assets/00000.webp",
                    height: MediaQuery.of(context).size.height*0.8,
                    width: double.infinity,
                    fit: BoxFit.fill,),
                )),
            Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.04)),
            // ignore: avoid_unnecessary_containers
            Container(
              child: Image.asset("assets/Untitled-1.png")
            )
          ],
        )
      ),
    );
  }
  bool isLogIn(){
    // String? name=sharedPreferences!.getString('name');
    String ?email=sharedPreferences!.getString('email');
    // print(name);
    // print(email);
    if(email==' '){
      // print('empty');
      return false;
    }
    else
      return true;
  }
}
