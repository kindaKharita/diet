import 'package:diet/app_function/app_func.dart';
import 'package:diet/app_function/item_ui_radio.dart';
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
class InfoPageContinue2 extends StatefulWidget {
  bool reg;

  InfoPageContinue2(this.reg);

  @override
  _InfoPageContinue2State createState() => _InfoPageContinue2State();
}

class _InfoPageContinue2State extends State<InfoPageContinue2> {
  List<String> allergyUser = [];
  List<bool> allergyUsers = [];

  void initState() {
    // TODO: implement initState
    allergyUser = sharedPreferences!.getStringList('food_allergy')!;
    for (int i = 0; i < listAllergy!.length; i++) {
      if (allergyUser.contains(listAllergy![i]['food'])) {
        allergyUsers.add(true);
      } else {
        allergyUsers.add(false);
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
              title: const Text('Allergy'),
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
            widget.reg ? HeaderContainer("Allergy", 0.2) : Container(),
            const Padding(padding: EdgeInsets.all(5)),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    // padding: EdgeInsets.all(10),
                    child: Question(question: "Do you have any allergies?"),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.topRight,
                    height: MediaQuery.of(context).size.height * 0.04,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: ButtonWidget(
                      onClick: ()  {
                        try {
                          if(widget.reg){
                            myUserApp =  AppFunction().getAllInfoUsre();
                            myUserApp!.addUser();

                          }else{
                            myUserApp!.allergies=sharedPreferences!.getStringList('food_allergy')!;
                            String email = sharedPreferences!.getString('email')!;
                            myUserApp!.update(email);
                          }
                          // AppFunction().initAllergyList(context);
                        } catch (e) {
                          // ignore: avoid_print
                          print(e);
                        }
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomBarPage(2)));
                      },
                      btnText: 'Next',
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 15),
                child: ListView(
                  // mainAxisSize: MainAxisSize.max,
                  padding: EdgeInsets.all(0),
                  children: <Widget>[
                    //_textInput(controller: gender, hint: "Male /Female"),
                    pickarViwe(listAllergy!, true),
                    // Padding(padding: EdgeInsets.all(20)),
                    // Center(
                    //   child: ButtonWidget(
                    //     onClick: () async {
                    //       try {
                    //         if(widget.reg){
                    //           myUserApp = await AppFunction().getAllInfoUsre();
                    //           myUserApp!.addUser();
                    //
                    //         }
                    //
                    //         // one.getCaloriesChange(); //to init daily calories for this user
                    //         // print(myUserApp!.email);
                    //
                    //         // print(myUserApp!.getBmiStates());
                    //         // print('cal:   ' + '${myUserApp!.calories}');
                    //         // AppFunction().initAllergyList(context);
                    //       } catch (e) {
                    //         // ignore: avoid_print
                    //         print(e);
                    //       }
                    //       Navigator.pushReplacement(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => BottomBarPage(2)));
                    //     },
                    //     btnText: widget.reg ? "NEXT" : 'Save',
                    //   ),
                    // ),
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
  Widget pickarViwe(List listV, bool isActive) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Column(
        children: <Widget>[
          for (int i = 0; i < listV.length; i++)
            ListTile(
              title: Text(
                listV[i]['allergy'],
              ),
              subtitle: Text(
                listV[i]['food'],
                style: const TextStyle(fontSize: 11),
              ),
              leading: IconButton(
                icon: allergyUsers[i]
                    ? Icon(
                        Icons.select_all,
                        color: colorhex,
                      )
                    : Icon(Icons.crop_square),

                // autofocus: Fo,
                onPressed: () async {
                  // print(allergyUser);
                  // print(listV[i].name);
                  if (!allergyUser.contains(listV[i]['food'])) {
                    allergyUser.add(listV[i]['food']);
                  } else {
                    allergyUser.remove(listV[i]['food']);
                  }
                  setState(() {
                    allergyUsers[i] = allergyUser.contains(listV[i]['food']);
                  });

                  await sharedPreferences!
                      .setStringList('food_allergy', allergyUser);
                  // isActive?print(''):Navigator.pushReplacement(    context,  MaterialPageRoute(
                  //     builder: (context) => this.build(context)));
                  // Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (context) => InfoPageContinue2()));
                },
              ),
              // subtitle: Text(selectedGender.toString()),
            ),
        ],
      ),
    );
  }
}
