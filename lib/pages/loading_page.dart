import 'dart:async';

import 'package:diet/pages/info_user_page_continue2.dart';
import 'package:diet/utils/app_suitable_widget_size.dart';
import 'package:diet/utils/color.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {



  void initState()  {
    // TODO: implement initState
    super.initState();


    Timer( Duration(milliseconds: 2000), () {


      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => isLoading()?InfoPageContinue2(true):LoadingPage()));
    });
  }


  @override
  Widget build(BuildContext context)
  {

    return Container(
      color: Colors.white.withOpacity(0.5),
      child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Container(
                child: SizedBox(
                  height: AppSuitableWidgetSize().getSuitableWidgetHeight(
                      45, context),
                  width: AppSuitableWidgetSize().getSuitableWidgetWidth(
                      45, context),
                  child: CircularProgressIndicator(
                    strokeWidth: AppSuitableWidgetSize()
                        .getSuitableWidgetWidth(4, context),
                    valueColor: AlwaysStoppedAnimation(colorhex),

                  ),
                ),
              ),
            ],
          )),
    );

  }
  bool isLoading(){
    if(listAllergy!=null){
      return true;
    }else{
      return false;
    }
  }
}
