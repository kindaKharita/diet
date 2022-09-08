import 'package:diet/app_function/app_func.dart';
import 'package:diet/app_function/item_ui_radio.dart';
import 'package:diet/pages/info_user_page_continue2.dart';
import 'package:diet/pages/me_page.dart';
import 'package:diet/provider/app_filtter_list_provider.dart';
import 'package:diet/utils/app_text_question_info.dart';
import 'package:diet/utils/color.dart';
import 'package:diet/widgets/bottom_bar.dart';
import 'package:diet/widgets/btn_widget.dart';
import 'package:diet/widgets/herder_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'loading_page.dart';

// class Item {
//   Item(this.name , this.sub);
//   var  name;
//   var sub;
// }

// ignore: use_key_in_widget_constructors
class InfoPageContinue extends StatefulWidget {
  bool reg;
  bool Act;
  bool dis;

  InfoPageContinue(this.reg, this.Act, this.dis);

  @override
  _InfoPageContinueState createState() => _InfoPageContinueState();
}

class _InfoPageContinueState extends State<InfoPageContinue> {
  int selectedPhysicalAct = 10;

  // int selectedDisease;
  List<String> selectedDisease = [];
  List<Item> listActive = <Item>[
    Item(name: 'Sedentary', sub: 'Little exercise, desk job'),
    Item(name: ' Lightly active', sub: 'Light exercise, sports 1-3 days/week'),
    Item(
        name: 'Moderately ',
        sub: 'active Moderate exercise, sports 3-5 days/week'),
    Item(name: 'Very active', sub: 'Hard exercise, sports 6-7 days/week'),
    Item(
        name: 'Extra active',
        sub:
            'Hard daily exercise, sports and physical labor job or 2 times training per day')
  ];
  List<bool> selectedDiseases = [];

  List<Item> listDisease = <Item>[
    Item(name: 'Diabetes'),
    Item(name: 'Heart Disease'),
    Item(name: 'Pressure Disease'),
    Item(name: 'Non Alcoholic'),
    Item(name: 'Vegetarian'),
  ];

  @override
  void initState() {
    // TODO: implement initState
    selectedDisease = sharedPreferences!.getStringList('disease')!;
    for (int i = 0; i < listDisease.length; i++) {
      if (selectedDisease.contains(listDisease[i].name)) {
        selectedDiseases.add(true);
      } else {
        selectedDiseases.add(false);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.reg
          ? AppBar(
              toolbarHeight: 0,
              backgroundColor: colorhex,
            )
          : AppBar(
              title: widget.Act ? const Text('Active') : const Text('Property'),
              backgroundColor: colorhex,
              actions: [
                IconButton(
                    onPressed: () {
                      // showSearch(context: context, delegate: DataSearch());
                    },
                    icon: const Icon(Icons.more_vert))
              ],
              elevation: 10,
              // leading:   IconButton(onPressed: (){}, icon: Icon(Icons.mo),
            ),
      body: Container(
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          children: <Widget>[
            widget.reg ? HeaderContainer("Properties", 0.25) : Container(),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 15),
                child: ListView(
                  // mainAxisSize: MainAxisSize.max,
                  padding: EdgeInsets.all(0),

                  children: <Widget>[
                    widget.Act
                        ? Container(
                            // padding: EdgeInsets.all(10),
                            child: Question(question: "What's your Active ?"),
                          )
                        : Container(),
                    //_textInput(controller: gender, hint: "Male /Female"),
                    widget.Act ? pickarViwe(listActive, true) : Container(),

                    Padding(padding: EdgeInsets.all(20)),

                    widget.dis
                        ? Container(
                            padding: EdgeInsets.all(10),
                            child:
                                Question(question: "Do you have a disease ?"),
                          )
                        : Container(),
                    //_textInput(controller: gender, hint: "Male /Female"),
                    widget.dis ? pickarViwe(listDisease, false) : Container(),
                    widget.dis
                        ? const Padding(padding: EdgeInsets.all(20))
                        : const Padding(padding: EdgeInsets.all(0)),
                    Center(
                      child: ButtonWidget(
                        onClick: widget.reg
                            ? () async {
                                AppFunction().initAllergyList(context);
                                try {
                                  if (selectedPhysicalAct <= 5) {
                                    await sharedPreferences!.setString(
                                        'active',
                                        listActive[selectedPhysicalAct - 1]
                                            .name);
                                    await sharedPreferences!.setString(
                                        'activity_lvl',
                                        selectedPhysicalAct.toString());
                                  }
                                  if (selectedDisease.isNotEmpty) {
                                    await sharedPreferences!.setStringList(
                                        'diseases', selectedDisease);
                                  }

                                  // one.getCaloriesChange(); //to init daily calories for this user

                                  print(myUserApp!.getBmiStates());
                                  print('cal:   ' + '${myUserApp!.calories}');
                                  // AppFunction().initAllergyList(context);
                                } catch (e) {
                                  // ignore: avoid_print
                                  print(e);
                                }
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoadingPage()));
                              }
                            : () async {
                                if (widget.Act) {
                                  if (selectedPhysicalAct <= 5) {
                                    await sharedPreferences!.setString(
                                        'active',
                                        listActive[selectedPhysicalAct - 1]
                                            .name);
                                    await sharedPreferences!.setString(
                                        'activity_lvl',
                                        selectedPhysicalAct.toString());
                                  }
                                  myUserApp!.activity_lvl = selectedPhysicalAct;
                                } else {
                                  if (selectedDisease.isNotEmpty) {
                                    await sharedPreferences!.setStringList(
                                        'diseases', selectedDisease);
                                  }
                                  myUserApp!.disease = sharedPreferences!
                                      .getStringList('disease')!;
                                }
                                String email =
                                    sharedPreferences!.getString('email')!;
                                myUserApp!.update(email);
                                AppFunction().initSportList();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BottomBarPage(4)));
                              },
                        btnText: widget.reg ? "NEXT" : 'Save',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: unused_element
  Widget pickarViwe(List<Item> listV, bool isActive) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Column(
        children: <Widget>[
          for (int i = 0; i < listV.length; i++)
            ListTile(
              title: Text(
                listV[i].name,
              ),
              subtitle: Text(
                isActive ? listV[i].sub : "",
                style: TextStyle(fontSize: 11),
              ),
              leading: isActive
                  ? Radio(
                      activeColor: colorhex,
                      value: i + 1,
                      groupValue: selectedPhysicalAct,
                      onChanged: (value) {
                        setState(() {
                          selectedPhysicalAct = value as int;
                        });
                      },
                    )
                  : IconButton(
                      icon: selectedDiseases[i]
                          ? Icon(
                              Icons.select_all,
                              color: colorhex,
                            )
                          : Icon(Icons.crop_square),

                      // autofocus: Fo,
                      onPressed: () async {
                        print(selectedDisease);
                        print(listV[i].name);
                        if (!selectedDisease.contains(listV[i].name)) {
                          selectedDisease.add(listV[i].name);
                        } else {
                          selectedDisease.remove(listV[i].name);
                        }
                        setState(() {
                          selectedDiseases[i] =
                              selectedDisease.contains(listV[i].name);
                        });
                        await sharedPreferences!.remove('disease');
                        await sharedPreferences!
                            .setStringList('disease', selectedDisease);

                        // isActive?print(''):Navigator.pushReplacement(    context,  MaterialPageRoute(
                        //     builder: (context) => this.build(context)));
                        // Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (context) => InfoPageContinue()));
                      },
                    ),
              // subtitle: Text(selectedGender.toString()),
            ),
        ],
      ),
    );
  }

  Future<void> _refresh() async {
    pickarViwe(listDisease, false);
  }
}
