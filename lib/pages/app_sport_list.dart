import 'package:diet/main.dart';
import 'package:diet/pages/information_food.dart';
import 'package:diet/utils/app_name_list_food.dart';
import 'package:diet/utils/color.dart';
import 'package:diet/widgets/show_dialog.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ViewSportPage extends StatefulWidget {
  List list;

  // ignore: use_key_in_widget_constructors
  ViewSportPage({required this.list});

  @override
  _ViewSportPageState createState() => _ViewSportPageState();
}

class _ViewSportPageState extends State<ViewSportPage> {
  List<bool> isAddSport = [];

  @override
  void initState() {
    sportName = sharedPreferences!.getStringList("sport")!;

    myUserApp!.sport_calories=0;
    for (int j = 0; j < widget.list.length; j++) {
      if (isAdd(widget.list[j]['activity_h'].toString())) {
        myUserApp!.sport_calories += widget.list[j]['calories_kg'];
        // print(myUserApp!.sport_calories);
        isAddSport.add(true);
        // print(sportName.length.toString()+' cds');
      } else {
        isAddSport.add(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sport'),
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

      body: ListView.builder(
          itemCount: widget.list.length,
          itemBuilder: (BuildContext context, int index) {
            // ignore: avoid_unnecessary_containers
            return Container(
              child: Column(
                children: [
                  InkWell(
                    child: ListTile(
                      title: Text(
                        widget.list[index]['activity_h'],
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      subtitle:
                          Text(widget.list[index]['calories_kg'].toString()),
                      leading: const Icon(
                        Icons.sports_handball,
                        color: Colors.deepPurple,
                      ),
                      trailing: IconButton(
                        icon: isAddSport[index]
                            ? const Icon(
                                // widget.isFav ? Icons.favorite:
                                Icons.add, color: Colors.red,
                              )
                            : const Icon(
                                // widget.isFav ? Icons.favorite:
                                Icons.add, color: Colors.black,
                              ),
                        onPressed: () async {
                          if (isAdd(
                              widget.list[index]['activity_h'].toString())) {
                            sportName.remove(
                                widget.list[index]['activity_h'].toString());
                            myUserApp!.sport_calories -=
                                widget.list[index]['calories_kg'];
                          } else {
                            if (myUserApp!.checkSport(
                                widget.list[index]['calories_kg'])) {
                              sportName.add(
                                  widget.list[index]['activity_h'].toString());
                              myUserApp!.sport_calories +=
                                  widget.list[index]['calories_kg'];
                              // print('tootoo');
                              // print(myUserApp!.sport_calories);
                            } else {
                              print('wrong in sport...');
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => CustomDialog(
                                  description:'cant add this sport, you reached to max burned calories',
                                  buttonText: "Okay", logOut: false,
                                ),
                              );
                            }
                          }
                          setState(() {
                            isAddSport[index] = isAdd(
                                widget.list[index]['activity_h'].toString());
                          });
                          // sharedPreferences!.remove('favourite');

                          // await sharedPreferences!.setStringList(
                          //     'myFavorite', myFav);
                          await sharedPreferences!
                              .setStringList('sport', sportName);
                          await sharedPreferences!.setDouble(
                              'sport-cal', myUserApp!.sport_calories);
                        },
                      ),
                    ),
                    onTap: () {
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(
                      //       builder: ( context) => InformationFood(list: widget.list[index]),));
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

  bool isAdd(title) {
    if (sportName.contains(title)) {
      return true;
    } else {
      return false;
    }
  }
}
