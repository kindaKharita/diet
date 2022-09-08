import 'package:diet/main.dart';
import 'package:diet/pages/information_food.dart';
import 'package:diet/utils/app_name_list_food.dart';
import 'package:diet/utils/color.dart';
import 'package:diet/widgets/show_dialog.dart';
import 'package:flutter/material.dart';

import 'diary.dart';

// ignore: must_be_immutable
class RecipesPage extends StatefulWidget {

  List listCopy;
  String namePage;
  List listCopy1=[];
  // ignore: use_key_in_widget_constructors
  RecipesPage({required this.listCopy, required this.namePage});

  @override
  _RecipesPageState createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  List<bool> isFavourite = [];

  @override
  void initState() {
    if (widget.namePage.startsWith(NameListFood.recipes)) {
      myFav = sharedPreferences!.getStringList("favourite")!;
      initCopyList();
      // TODO: implement initState
      for (int j = 0; j < widget.listCopy1.length; j++) {
        if (isFavOrAdd(widget.listCopy1[j]['title'].toString(), myFav))
          isFavourite.add(true);
        else {
          isFavourite.add(false);
        }
      }
    } else {
      filtterDishType(widget.namePage);
      dishTypeFood = [];
      dishTypeFood = sharedPreferences!.getStringList(widget.namePage)!;

      myUserApp!.curr_calories = 0;
      cMyCuurentCal();
      for (int j = 0; j < widget.listCopy1.length; j++) {
        if (isFavOrAdd(widget.listCopy1[j]['title'].toString(), dishTypeFood)) {
          isFavourite.add(true);
        } else {
          isFavourite.add(false);
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.namePage.startsWith(NameListFood.recipes)?const Text('Favourite'):Text(widget.namePage),
        backgroundColor: colorhex,

        elevation: 10,
        // leading:   IconButton(onPressed: (){}, icon: Icon(Icons.mo),
      ),

      body: ListView.builder(
          itemCount: widget.listCopy1.length,
          itemBuilder: (BuildContext context, int index) {
            // ignore: avoid_unnecessary_containers
            // print(widget.list);
            return Container(
              child: Column(
                children: [
                  InkWell(
                    child: ListTile(
                      title: Text(
                        widget.listCopy1[index]['title'].toString(),
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      subtitle: Text(widget.listCopy1[index]['calories'].toString()),
                      leading: Image.network(
                        widget.listCopy1[index]['image'].toString(),
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: MediaQuery.of(context).size.height * 0.35,
                        fit: BoxFit.fill,
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          // widget.isFav=!widget.isFav,
                          // listFavoriteFood.add(widget.list[index]);
                          if (widget.namePage
                              .startsWith(NameListFood.recipes)) {
                            if (isFavOrAdd(
                                widget.listCopy1[index]['title'].toString(),
                                myFav)) {
                              myFav.remove(
                                  widget.listCopy1[index]['title'].toString());
                            } else {
                              myFav.add(widget.listCopy1[index]['title'].toString());
                            }
                            setState(() {
                              isFavourite[index] = isFavOrAdd(
                                  widget.listCopy1[index]['title'].toString(),
                                  myFav);
                            });
                            // sharedPreferences!.remove('favourite');

                            // await sharedPreferences!.setStringList(
                            //     'myFavorite', myFav);
                            await sharedPreferences!
                                .setStringList('favourite', myFav);
                            // List<String>? list =
                            //     sharedPreferences!.getStringList("favourite");
                            // print('117 ricpes ' + list.toString());
                          } else {
                            if (isFavOrAdd(
                                widget.listCopy1[index]['title'].toString(),
                                dishTypeFood)) {
                              dishTypeFood.remove(
                                  widget.listCopy1[index]['title'].toString());
                              myUserApp!.curr_calories -=
                                  widget.listCopy1[index]['calories'];
                            } else {
                              if (myUserApp!
                                  .checkFood(widget.listCopy1[index]['calories'])) {

                                dishTypeFood.add(
                                    widget.listCopy1[index]['title'].toString());
                                myUserApp!.curr_calories +=
                                    widget.listCopy1[index]['calories'];
                                // print('wooooooooooooooooooooo');
                                // print(myUserApp!.curr_calories);
                              } else {
                                print('wrong...');
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) => CustomDialog(
                                    description: 'cant add this food, you reached to max calories',
                                    buttonText: "Okay",
                                    logOut: false,
                                  ),
                                );
                              }
                            }
                            setState(() {
                              isFavourite[index] = isFavOrAdd(
                                  widget.listCopy1[index]['title'].toString(),
                                  dishTypeFood);
                            });
                            // sharedPreferences!.remove(widget.namePage);

                            // await sharedPreferences!.setStringList(
                            //     'myFavorite', myFav);
                            await sharedPreferences!
                                .setStringList(widget.namePage, dishTypeFood);
                          }
                          sharedPreferences!
                              .setDouble('curr-cal', myUserApp!.curr_calories);
                          myUserApp!.curr_calories= sharedPreferences!
                              .getDouble('curr-cal')!;

                        },
                        icon: widget.namePage == NameListFood.recipes
                            ? isFavourite[index]
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : const Icon(Icons.favorite_border)
                            : isFavourite[index]
                                ? const Icon(
                                    Icons.add,
                                    color: Colors.red,
                                  )
                                : const Icon(Icons.add),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            InformationFood(list: widget.listCopy1[index]),
                      ));
                    },
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                ],
              ),
            );
          }),
      // drawer: Drawer(
      // child:ListDrawar(),
      // ),
      // body: RecipesPage(),
    );
  }
  void initCopyList(){
    myFav = sharedPreferences!.getStringList('favourite')!;
    widget.listCopy1=[];
    for(int i=0;i<listFoodAfterFilterAllergy!.length;i++){
      if(myFav.contains(listFoodAfterFilterAllergy![i]['title'])){

        widget.listCopy1.add(listFoodAfterFilterAllergy![i]);

      }
    }
  }
  void cMyCuurentCal() {
    List<String> list =
    sharedPreferences!.getStringList(NameListFood.breakfast)!;
    list.addAll(sharedPreferences!.getStringList(NameListFood.lunch)!);
    list.addAll(sharedPreferences!.getStringList(NameListFood.dinner)!);
    list.addAll(sharedPreferences!.getStringList(NameListFood.snack)!);
    list.addAll(sharedPreferences!.getStringList(NameListFood.appetizers)!);
    // print(list.length.toString()+' yoyo');
    for (int j = 0; j < list.length; j++) {
      // print('currrrrrr:' + myUserApp!.curr_calories.toString());
      myUserApp!.curr_calories += calfood(list[j]);
    }
  }

  void filtterDishType(dish){
    if(NameListFood.breakfast!=dish){
      isFoundOtherDishType(NameListFood.breakfast);
    }
    if(NameListFood.lunch!=dish){
      isFoundOtherDishType(NameListFood.lunch);
    }
    if(NameListFood.dinner!=dish){
      isFoundOtherDishType(NameListFood.dinner);
    }
    if(NameListFood.snack!=dish){
      isFoundOtherDishType(NameListFood.snack);
    }
    if(NameListFood.appetizers!=dish){
      isFoundOtherDishType(NameListFood.appetizers);
    }
  }

  void isFoundOtherDishType(dishType){
    dishTypeFood = [];
    dishTypeFood = sharedPreferences!.getStringList(dishType)!;
    print(dishTypeFood);
    for(int i=0;i<widget.listCopy.length;i++){
      if(!dishTypeFood.contains(widget.listCopy[i]['title'])){

        widget.listCopy1.add(widget.listCopy[i]);

      }
    }
  }
  double calfood(title) {
    for (int i = 0; i < listFoodAfterFilterAllergy!.length; i++) {
      if (listFoodAfterFilterAllergy![i]['title'].toString().contains(title)) {
        return listFoodAfterFilterAllergy![i]['calories'];
      }
    }
    return 0.0;
  }

  bool isFavOrAdd(title, List<String> listFoodName) {
    if (listFoodName.contains(title)) {
      return true;
    } else {
      return false;
    }
  }
}
