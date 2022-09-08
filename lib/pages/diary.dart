import 'package:diet/app_function/item_ui_radio.dart';
import 'package:diet/firebase/sport.dart';
import 'package:diet/pages/app_sport_list.dart';
import 'package:diet/pages/recipes.dart';
import 'package:diet/provider/app_filtter_list_provider.dart';
import 'package:diet/utils/app_name_list_food.dart';
import 'package:diet/utils/color.dart';
import 'package:diet/widgets/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../main.dart';

class DiaryPage extends StatefulWidget {
  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  List? foodDishType;
  List? foodCalories;
  double goal = 0;
  double food = 0;
  double exercise = 0;
  double remaining = 0;
  int lenBreakFast = 0;
  int lenLunch = 0;
  int lenDinner = 0;
  int lenSnack = 0;
  int lenApp = 0;
  int lenSport = 0;
  DateTime time = DateTime.now();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  ///dishTypes: lunch ; dinner ; breakfast ; snack ; appetizers
  List<Item> dishType = <Item>[
    Item(name: 'breakfast'),
    Item(name: 'lunch'),
    Item(name: 'dinner'),
    Item(name: 'appetizers'),
    Item(name: 'snack'),
  ];

  @override
  void initState() {
    setState(() {
      goal = sharedPreferences!.getDouble('cal')!;
      food = sharedPreferences!.getDouble("curr-cal")!;
      exercise = sharedPreferences!.getDouble('sport-cal')!;
      remaining = goal - food + exercise;

      dishTypeFood = sharedPreferences!.getStringList(NameListFood.breakfast)!;
      lenBreakFast = dishTypeFood.length;
      dishTypeFood = sharedPreferences!.getStringList(NameListFood.lunch)!;
      lenLunch = dishTypeFood.length;
      dishTypeFood = sharedPreferences!.getStringList(NameListFood.dinner)!;
      lenDinner = dishTypeFood.length;
      dishTypeFood = sharedPreferences!.getStringList(NameListFood.snack)!;
      lenSnack = dishTypeFood.length;
      dishTypeFood = sharedPreferences!.getStringList(NameListFood.appetizers)!;
      lenApp = dishTypeFood.length;
      sportName = sharedPreferences!.getStringList("sport")!;
      lenSport = sportName.length;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diary"),
        backgroundColor: colorhex,
       
        elevation: 10,
        // leading:   IconButton(onPressed: (){}, icon: Icon(Icons.mo),
      ),
      // drawer: Drawer(
      // child:ListDrawar(),
      // ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: SingleChildScrollView(
          // width: double.infinity,//MediaQuery.of(context).size.width,
          // height:double.infinity,// MediaQuery.of(context).size.height,
          child: Container(
            width: MediaQuery.of(context).size.width,
            // height:double.infinity,
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(time.year.toString() +
                              '/' +
                              time.month.toString() +
                              '/' +
                              time.day.toString()),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 5,
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: const Text(
                    "Calories Remaining",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    children: [
                      buildExpanded(goal.toStringAsFixed(1), "Goal", 6),
                      buildExpanded("-", "", 1),
                      buildExpanded(food.toStringAsFixed(1), "Food", 6),
                      buildExpanded("+", "", 1),
                      buildExpanded(exercise.toStringAsFixed(1), "Exercise", 6),
                      buildExpanded("=", "", 1),
                      buildExpanded(
                          remaining.toStringAsFixed(1), "Remaining", 6),
                    ],
                  ),
                ),
                Container(
                  height: 7,
                  color: Colors.grey,
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                buildSnackExp(5.0, 5.0, 5.0, NameListFood.breakfast,
                    lenBreakFast.toString()),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                const Divider(
                  height: 5,
                ),
                const Padding(padding: EdgeInsets.only(bottom: 5)),
                buildAddFoodExp(
                    5.0, 10.0, 10.0, "Add Food", NameListFood.breakfast),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                Container(
                  height: 7,
                  color: Colors.grey,
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                buildSnackExp(
                    5.0, 5.0, 5.0, NameListFood.lunch, lenLunch.toString()),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                const Divider(
                  height: 5,
                ),
                const Padding(padding: EdgeInsets.only(bottom: 5)),
                buildAddFoodExp(
                    5.0, 10.0, 10.0, "Add Food", NameListFood.lunch),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                Container(
                  height: 7,
                  color: Colors.grey,
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                buildSnackExp(
                    5.0, 5.0, 5.0, NameListFood.dinner, lenDinner.toString()),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                const Divider(
                  height: 5,
                ),
                const Padding(padding: EdgeInsets.only(bottom: 5)),
                buildAddFoodExp(
                    5.0, 10.0, 10.0, "Add Food", NameListFood.dinner),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                Container(
                  height: 7,
                  color: Colors.grey,
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                buildSnackExp(
                    5.0, 5.0, 5.0, NameListFood.snack, lenSnack.toString()),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                const Divider(
                  height: 5,
                ),
                const Padding(padding: EdgeInsets.only(bottom: 5)),
                buildAddFoodExp(
                    5.0, 10.0, 10.0, "Add Food", NameListFood.snack),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                Container(
                  height: 7,
                  color: Colors.grey,
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                buildSnackExp(
                    5.0, 5.0, 5.0, NameListFood.appetizers, lenApp.toString()),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                const Divider(
                  height: 5,
                ),
                const Padding(padding: EdgeInsets.only(bottom: 5)),
                buildAddFoodExp(
                    5.0, 10.0, 10.0, "Add Food", NameListFood.appetizers),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                Container(
                  height: 7,
                  color: Colors.grey,
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                buildSnackExp(
                    5.0, 5.0, 5.0, NameListFood.sport, lenSport.toString()),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                const Divider(
                  height: 5,
                ),
                const Padding(padding: EdgeInsets.only(bottom: 5)),
                buildAddFoodExp(
                    5.0, 10.0, 10.0, "Add Sport", NameListFood.sport),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                Container(
                  padding: EdgeInsets.all(30),
                  child: Container(
                    decoration: BoxDecoration(
                        color: colorhex,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                      onPressed: () async {

                        showDialog(
                          context: context,
                          builder: (BuildContext context) => CustomDialog(
                            description: myUserApp!.checkCompletePlan(),
                            buttonText: "Okay", logOut: false,
                          ),
                        );
                        if( myUserApp!.plan_date !=0||  myUserApp!.plan_date != DateTime.now().day)
                       {
                          myUserApp!.plan_date = DateTime.now().day;

                          await sharedPreferences!.setString(
                              'plan_date', DateTime.now().day.toString());
                          myUserApp!.update(myUserApp!.email);

                        }


                      },
                      // ignore: prefer_const_constructors
                      child: Text("CompleteDiary",
                          style: const TextStyle(color: Colors.white, fontSize: 14)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 500));
    // if failed,use refreshFailed()
    setState(() {
      goal = sharedPreferences!.getDouble('cal')!;
      food = sharedPreferences!.getDouble("curr-cal")!;
      exercise = sharedPreferences!.getDouble('sport-cal')!;
      remaining = goal - food + exercise;

      dishTypeFood = sharedPreferences!.getStringList(NameListFood.breakfast)!;
      lenBreakFast = dishTypeFood.length;
      dishTypeFood = sharedPreferences!.getStringList(NameListFood.lunch)!;
      lenLunch = dishTypeFood.length;
      dishTypeFood = sharedPreferences!.getStringList(NameListFood.dinner)!;
      lenDinner = dishTypeFood.length;
      dishTypeFood = sharedPreferences!.getStringList(NameListFood.snack)!;
      lenSnack = dishTypeFood.length;
      dishTypeFood = sharedPreferences!.getStringList(NameListFood.appetizers)!;
      lenApp = dishTypeFood.length;
      sportName = sharedPreferences!.getStringList("sport")!;
      lenSport = sportName.length;
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    _refreshController.loadComplete();
  }

  Widget buildExpanded(String textExp, String textExpSub, int flexExp) {
    return Expanded(
      flex: flexExp,
      child: Container(
        child: ListTile(
          title: Container(
              alignment: Alignment.center,
              child: Text(
                textExp,
                style: TextStyle(fontSize: 14),
              )),
          subtitle: Container(
              alignment: Alignment.center,
              child: Text(
                textExpSub,
                style: TextStyle(fontSize: 12, color: Colors.red),
              )),
        ),
      ),
    );
  }

  Widget buildSnackExp(
      topPadding, rightPadding, leftPadding, nameFood, countFood) {
    return Container(
        child: Container(
            padding: EdgeInsets.only(top: topPadding),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  padding: EdgeInsets.only(left: leftPadding),
                  child: Text(
                    nameFood,
                    style: TextStyle(fontSize: 14),
                  ),
                )),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.only(right: rightPadding),
                  alignment: Alignment.topRight,
                  child: Text(
                    countFood,
                    style: TextStyle(fontSize: 14),
                  ),
                )),
              ],
            )));
  }

  Widget buildAddFoodExp(
      topPadding, rightPadding, leftPadding, nameTitle, nameDishType) {
    return Container(
        child: Container(
            padding: EdgeInsets.only(top: topPadding),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                        padding: EdgeInsets.only(left: leftPadding),
                        child: InkWell(
                          child: Row(
                            children: [
                              Icon(Icons.add),
                              Text(
                                nameTitle,
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          onTap: () async {
                            if (nameDishType == NameListFood.sport) {
                              ///to apply all sports on specific body
                              // sport.calAllForWeight(65, allSports);

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      ViewSportPage(list: allSports!)));
                            } else {
                              showFilterDishType(nameDishType);

                              setState(() {
                                goal = sharedPreferences!.getDouble('cal')!;
                                food =
                                    sharedPreferences!.getDouble("curr-cal")!;
                                exercise =
                                    sharedPreferences!.getDouble('sport-cal')!;
                                remaining = goal - food + exercise;

                                dishTypeFood = sharedPreferences!
                                    .getStringList(NameListFood.breakfast)!;
                                lenBreakFast = dishTypeFood.length;
                                dishTypeFood = sharedPreferences!
                                    .getStringList(NameListFood.lunch)!;
                                lenLunch = dishTypeFood.length;
                                dishTypeFood = sharedPreferences!
                                    .getStringList(NameListFood.dinner)!;
                                lenDinner = dishTypeFood.length;
                                dishTypeFood = sharedPreferences!
                                    .getStringList(NameListFood.snack)!;
                                lenSnack = dishTypeFood.length;
                                dishTypeFood = sharedPreferences!
                                    .getStringList(NameListFood.appetizers)!;
                                lenApp = dishTypeFood.length;
                                sportName =
                                    sharedPreferences!.getStringList("sport")!;
                                lenSport = sportName.length;
                              });

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => RecipesPage(
                                      listCopy: foodDishType!,
                                      namePage: nameDishType)));
                            }
                          },
                        ))),

              ],
            )));
  }

  Future<void> showFilterDishType(String dishType) async {
    try {
      ///claories
      foodCalories = await Provider.of<AppProvider>(context, listen: false)
          .filterCalories(400, listFoodAfterFilterAllergy!);
      foodDishType = await Provider.of<AppProvider>(context, listen: false)
          .filterDishTypeList(dishType.toLowerCase(), foodCalories!);
    } catch (e) {
      print("error");
      print(e);
    }
  }
}
