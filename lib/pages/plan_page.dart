import 'package:diet/utils/app_name_list_food.dart';
import 'package:diet/utils/color.dart';
import 'package:diet/widgets/card_food.dart';
import 'package:diet/widgets/list_viwe_card.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class PlanFood extends StatefulWidget {
  @override
  _PlanFoodState createState() => _PlanFoodState();
}

class _PlanFoodState extends State<PlanFood> {
  List listViweCardFood = [];

  @override
  void initState() {
    // TODO: implement initState
    int v=DateTime.now().day;
    if (myUserApp!.plan_date !=v ) {
      // print(myUserApp!.plan_date);
      // print( DateTime.now().day);
      // print('yeeees');
      sharedPreferences!.setStringList('+sport', []);
      sharedPreferences!.setStringList(NameListFood.breakfast, []);
      sharedPreferences!.setStringList(NameListFood.lunch, []);
      sharedPreferences!.setStringList(NameListFood.dinner, []);
      sharedPreferences!.setStringList(NameListFood.snack, []);
      sharedPreferences!.setStringList(NameListFood.appetizers, []);
      sharedPreferences!.setDouble('sport-cal', 0.0);
      sharedPreferences!.setDouble('curr-cal', 0);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan'),
        backgroundColor: colorhex,

        elevation: 10,
        // leading:   IconButton(onPressed: (){}, icon: Icon(Icons.mo),
      ),
      body: myUserApp!.plan_date != DateTime.now().day
          ? Container(
              alignment: Alignment.center,
              child: const Text('Create New Plan'),
            )
          : myUserApp!.checkCompletePlan() == 'plan Completed' ||
                  myUserApp!.checkCompletePlan() ==
                      "You need to add some exercises"
              ? SingleChildScrollView(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Padding(padding: EdgeInsets.all(10)),
                        ListViweFood(
                          name: NameListFood.breakfast,
                          isSport: false,
                        ),
                        const Padding(padding: EdgeInsets.all(10)),
                        ListViweFood(name: NameListFood.lunch, isSport: false),
                        const Padding(padding: EdgeInsets.all(10)),
                        ListViweFood(name: NameListFood.dinner, isSport: false),
                        const Padding(padding: EdgeInsets.all(10)),
                        ListViweFood(name: NameListFood.snack, isSport: false),
                        const Padding(padding: EdgeInsets.all(10)),
                        ListViweFood(
                            name: NameListFood.appetizers, isSport: false),
                        const Padding(padding: EdgeInsets.all(10)),
                        ListViweFood(name: 'sport', isSport: true),
                        Container(
                          alignment: Alignment.center,
                          child: Text(myUserApp!.checkCompletePlan()),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.001,
                        )
                      ],
                    ),
                  ),
                )
              : Container(
                  alignment: Alignment.center,
                  child: Text(myUserApp!.checkCompletePlan()),
                ),
    );
  }
}
