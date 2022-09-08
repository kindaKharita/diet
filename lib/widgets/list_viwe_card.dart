import 'package:diet/widgets/card_sport.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'card_food.dart';
class ListViweFood extends StatelessWidget {
  List listViweCardFood = [];
  String name;
  bool isSport;
  ListViweFood({required this.name,required this.isSport});
  @override
  Widget build(BuildContext context) {
    listViweCardFood=[];
    dishTypeFood = sharedPreferences!.getStringList(name)!;
   isSport?indexSpot(): indexFood();
    // print(dishTypeFood);
    return dishTypeFood.isNotEmpty? Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text(name+" : ",style: TextStyle(fontSize: 20),),
          ),
          const Padding(padding: EdgeInsets.all(10)),
          Container(

            width: MediaQuery.of(context).size.width,
            height:isSport? MediaQuery.of(context).size.height *0.2: MediaQuery.of(context).size.height *0.35,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listViweCardFood.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                        color: Colors.black12,
                        width: MediaQuery.of(context).size.width*0.001,
                        height: MediaQuery.of(context).size.height *0.3,

                      ),
                      isSport?CardSport(listViweCardFood[index], 0.2, 0.4, true): CardFoodList(listViweCardFood[index], 0.35,0.4,true),
                    ],
                  );
                }
            ),
          )
        ],
      ),
    ):Container();
  }
  void indexFood() {

    for (int i = 0; i < listFoodAfterFilterAllergy!.length; i++) {
      if (dishTypeFood.contains(listFoodAfterFilterAllergy![i]['title']))
        listViweCardFood.add(listFoodAfterFilterAllergy![i]);
    }
  }
  void indexSpot() {

    for (int i = 0; i < allSports!.length; i++) {
      if (dishTypeFood.contains(allSports![i]['activity_h']))
        listViweCardFood.add(allSports![i]);
    }
  }
}
