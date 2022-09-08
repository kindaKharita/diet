import 'package:flutter/material.dart';

class AppColumnInfo extends StatelessWidget {
  var percent;
  var name;
  var amount;
  var color;
  AppColumnInfo(this.amount,this.percent,this.name,this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(percent.toString()+"%",style: TextStyle(fontSize: 11,color: color),),
          // const Padding(padding: EdgeInsets.all(2)),
          Text(amount.toString(),style: TextStyle(fontSize: 14),),
          // const Padding(padding: EdgeInsets.all(2)),
          Text(name,style: TextStyle(fontSize: 11),),
        ],

      ),
    );
  }
}
