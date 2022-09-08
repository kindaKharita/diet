import 'package:diet/pages/information_food.dart';
import 'package:diet/recommendation/recommend.dart';
import 'package:diet/utils/app_name_list_food.dart';
import 'package:diet/utils/color.dart';
import 'package:diet/widgets/show_dialog.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class CardFoodList extends StatefulWidget {
  var foodCard;

  var h;
  var w;
  var isPlan;
  bool isfav = false;
  bool isAdd = false;
  // ignore: use_key_in_widget_constructors
  CardFoodList(this.foodCard, this.h, this.w, this.isPlan);

  @override
  _CardFoodListState createState() => _CardFoodListState();
}

class _CardFoodListState extends State<CardFoodList> {


  bool isFavourite() {
    myFav = sharedPreferences!.getStringList("favourite")!;

    // TODO: implement initState
    if (myFav.contains(
      widget.foodCard['title'],
    )) {
      return true;
    }
    return false;
  }


  @override
  Widget build(BuildContext context) {
    widget.isfav = isFavourite();
    return Card(
      elevation: 8,
      shadowColor: colorhex,
      margin: EdgeInsets.all(10),
      shape: widget.isPlan
          ? const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            )
          : OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.white)),
      child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => InformationFood(list: widget.foodCard)));
          },
          child: Container(
            width: MediaQuery.of(context).size.width * widget.w,
            height: MediaQuery.of(context).size.height * widget.h,
            child: Stack(children: <Widget>[
              ClipRRect(
                borderRadius: widget.isPlan
                    ? BorderRadius.circular(5)
                    : BorderRadius.circular(20),
                child: Image.network(
                  widget.foodCard['image'],
                  width: MediaQuery.of(context).size.width * widget.w,
                  height:
                      MediaQuery.of(context).size.height * (widget.h - 0.15),
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                // top: 20,
                right: 0.1,
                bottom: 15,
                child: Container(
                  child: IconButton(
                    icon: widget.isfav
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : Icon(Icons.favorite_border),
                    onPressed: () async {
                      if (isFavourite()) {
                        myFav.remove(widget.foodCard['title']);
                      } else {
                        myFav.add(widget.foodCard['title']);
                      }
                      await sharedPreferences!
                          .setStringList('favourite', myFav);
                      Recommend rec = Recommend();
                      var fetchedFood = await rec.fetch();
                      setState(() {
                        widget.isfav = isFavourite();
                        //TODO init rec food
                        print(allRecFoods!.length.toString() + 'sasf');
                        allRecFoods = fetchedFood;
                        print(allRecFoods!.length.toString() + 'sasf');
                      });
                    },
                  ),
                ),
              ),

              Positioned(
                // top: 20,
                left: 5,
                bottom: 35,
                child: Container(
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.foodCard['title'],
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            widget.foodCard['calories'].toString(),
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ]),
          )),
    );
  }

}
