
import 'package:diet/app_function/item_ui_radio.dart';
import 'package:diet/pages/info_user_page_continue.dart';
import 'package:diet/utils/app_text_forms.dart';
import 'package:diet/utils/app_text_question_info.dart';
import 'package:diet/utils/form_text_type.dart';
import 'package:diet/widgets/bottom_bar.dart';
import 'package:diet/widgets/btn_widget.dart';
import 'package:diet/widgets/herder_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

// class Item {
//   Item(this.name);
//   var  name;
// }

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  TextEditingController age = TextEditingController();
  TextEditingController lenght = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController gender = TextEditingController();

  GlobalKey<FormState> keySignIn1 = GlobalKey<FormState>();
  GlobalKey<FormState> keySignIn2 = GlobalKey<FormState>();
  GlobalKey<FormState> keySignIn3 = GlobalKey<FormState>();
  GlobalKey<FormState> keySignIn4 = GlobalKey<FormState>();
  int ?selectedPhysicalAct;
  int selectedGender=3;
  List<Item> listGender = <Item>[
     Item( name :'Male'),
     Item(name :'Female'),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          children: <Widget>[
            HeaderContainer("Information", 0.25),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: ListView(
                  // mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Question(question: "How old are you ?"),
                    AppTextForms.registerTextForm(
                        keySignIn1,
                        context,
                        "Age",
                        0.8,
                        100,
                        age,
                        FormTextType.Field,
                        TextInputType.number, () {},''),
                    Question(question: "What is your Length ?"),
                    AppTextForms.registerTextForm(
                        keySignIn2,
                        context,
                        "Length",
                        0.8,
                        100,
                        lenght,
                        FormTextType.Field,
                        TextInputType.number, () {},''),
                    Question(question: "How much do you weight ?"),
                    AppTextForms.registerTextForm(
                        keySignIn3,
                        context,
                        "Weight",
                        0.8,
                        100,
                        weight,
                        FormTextType.Field,
                        TextInputType.number, () {},''),
                    Question(question: "What's your gender ?"),
                    //_textInput(controller: gender, hint: "Male /Female"),
                    pickarViwe(listGender),


                  ],
                ),
              ),
            ),
            Center(
              child: ButtonWidget(

                onClick: () async {
                  if(age.text.isNotEmpty){
                    sharedPreferences!.remove('age');
                    await sharedPreferences!.setString('age', age.text.toString());
                  }
                  if(weight.text.isNotEmpty){
                    sharedPreferences!.remove('weight');
                    await sharedPreferences!.setString('weight', weight.text.toString());
                  }
                  if(lenght.text.isNotEmpty){
                    sharedPreferences!.remove('height');
                    await sharedPreferences!.setString('height', lenght.text.toString());
                  }
                  if(selectedGender!=3){
                    await sharedPreferences!.setString('gender', listGender[selectedGender-1].toString());
                    sharedPreferences!.remove('gender_id');
                    await sharedPreferences!.setString('gender_id', selectedGender.toString());
                  }
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InfoPageContinue(true,true,true)));
                },
                btnText: "NEXT",
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: unused_element
  Widget pickarViwe(List<Item> listV) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Column(
        children: <Widget>[
          for (int i = 0; i <listV.length; i++)
            ListTile(
              title: Text(
                 listV[i].name,
              ),
              leading: Radio(
                value: i+1,
                groupValue: selectedGender,
                onChanged:( value) {
                  setState(() {
                    selectedGender =(value as int?)!;
                  });
                },
              ),
              // subtitle: Text(selectedGender.toString()),
            ),
        ],
      ),
    );
  }

}
