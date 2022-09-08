import 'package:diet/utils/color.dart';
import 'package:flutter/material.dart';

class CardSport extends StatelessWidget {
  var sport;

  var h;
  var w;
  var isPlan;
  // ignore: use_key_in_widget_constructors
  CardSport(this.sport,this.h,this.w,this.isPlan);

  @override
  Widget build(BuildContext context) {
    return Card(

      elevation: 8,
      shadowColor: colorhex,
      margin: EdgeInsets.all(10),
      shape: isPlan?  const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ):OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white)),
      child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print('Card tapped.');
          },
          child:Container(
            width: MediaQuery.of(context).size.width*w,
            height: MediaQuery.of(context).size.height * h,

            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  child:const Icon(Icons.sports_handball,size: 75,color: Colors.grey,) ,
                ),
                Text(sport['activity_h'].toString(),style: const TextStyle(fontSize: 14),),
                Text(sport['calories_kg'].toString(),style: const TextStyle(fontSize: 12,),),
              ],
            )
          )
      ),
    );
  }
}
