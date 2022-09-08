import 'package:diet/utils/app_column_info.dart';
import 'package:diet/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../main.dart';

// ignore: use_key_in_widget_constructors
class InformationFood extends StatefulWidget {
  var list;
  bool isfav=false;
  // ignore: use_key_in_widget_constructors
  InformationFood({required this.list});
  @override
  _InformationFoodState createState() => _InformationFoodState();
}

class _InformationFoodState extends State<InformationFood> {

  bool isShowMore= false;
  @override
  Widget build(BuildContext context) {
    List ingList=widget.list['ingredients'];
    widget.isfav=isFavourite();
    print(ingList);
    return Scaffold(
      body:  SingleChildScrollView(
        // ignore: avoid_unnecessary_containers
        child: Container(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.3,
                child: Image.network(
                  widget.list['image'],
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.3,
                  fit: BoxFit.cover,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 5)),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        alignment: Alignment.bottomLeft,
                        child: Text(widget.list['title'],style: TextStyle(fontSize: 20),),
                      ),
                  ),
                  Expanded(
                      child: Container(
                        child: IconButton(
                          icon: widget.isfav?const Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite_border),
                          onPressed: () async {
                            if(isFavourite()){
                              myFav.remove(widget.list['title']);
                            }else{
                              myFav.add(widget.list['title']);
                            }
                            await sharedPreferences!
                                .setStringList('favourite', myFav);
                            setState(() {
                              widget.isfav=isFavourite();
                            });
                          },
                        ),
                      ),
                  ),

                ],
              ),
              const Divider(height: 15,),
              // ignore: prefer_const_constructors
              Container(
                // height: 10,
                padding: EdgeInsets.only(left: 10),
                alignment: Alignment.bottomLeft,
                child: const Text("Nutrition Per Serving : ",style: TextStyle(fontSize: 14),),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.13,
                child: Row(
                  children: [
                    Expanded(
                      child:Container(
                        padding: EdgeInsets.only(top: 15,left: 20,right: 20,bottom: 10),
                        child:  CircularStepProgressIndicator(
                          totalSteps:100,
                          currentStep: 100,
                          stepSize: 2,
                          // selectedColor: Colors.greenAccent,
                          // unselectedColor: Colors.grey[200],
                          padding: 3.14 / 80,
                          // width: 50,
                          // height: 100,
                          selectedStepSize: 5,
                          // roundedCap: (_, __) => true,
                          customColor: (index) => index < widget.list['per_fat'].toInt()?
                          Colors.blue:
                          index <  widget.list['per_protein'].toInt()?
                          Colors.purple:
                          Colors.green,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(widget.list['calories'].toString(),style: TextStyle(fontSize: 14),),
                              Text('Cal',style: TextStyle(fontSize: 11),),
                            ],
                          ),
                        ),
                      )),
                    Expanded(child: AppColumnInfo(widget.list['fat_g'],widget.list['per_fat'],'fat',Colors.blue)),
                    Expanded(child: AppColumnInfo(widget.list['carbohydrates_g'],widget.list['per_carbs'],'carbohydrate',Colors.purple)),
                    Expanded(child: AppColumnInfo(widget.list['protein_g'],widget.list['per_protein'],'protein',Colors.green)),
                  ],
                ),
              ),
              Container(
                height: 50,
                alignment: Alignment.bottomLeft,
                child: TextButton(
                  onPressed: (){
                    setState(() {
                      isShowMore=!isShowMore;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text('Show More',style:  TextStyle(fontSize: 12,color: Colors.purple),),
                      const Icon(Icons.expand_more_sharp,color: Colors.black,),
                    ],
                  )
                ),
              ),
              isShowMore ?Container(
                child: Column(
                  children: [
                      Container(
                        padding: EdgeInsets.only(left: 25),
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            const Text('Alcohol : '),
                            Text(widget.list['alcohol_g'].toString()),
                            const Text(' g'),
                          ],
                        )
                      ),
                    Container(
                        padding: EdgeInsets.only(left: 25),
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            const Text('Calcium : '),
                            Text(widget.list['calcium_mg'].toString()),
                            const Text(' mg'),
                          ],
                        )
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 25),
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            const Text('Cholesterol : '),
                            Text(widget.list['cholesterol_mg'].toString()),
                            const Text(' mg'),
                          ],
                        )
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 25),
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            const Text('Vitamin C : '),
                            Text(widget.list['vit_c_mg'].toString()),
                            const Text(' mg'),
                          ],
                        )
                    ),

                  ],
                ),
              ):Container(),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              Container(
                padding: EdgeInsets.only(left: 10),
                alignment: Alignment.bottomLeft,
                child: Text("Ingredients : ",style: TextStyle(fontSize: 14),),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    for(int i=0;i<ingList.length;i++)
                      Container(
                        padding: EdgeInsets.only(left: 25),
                        alignment: Alignment.topLeft,
                        child: Text(ingList[i]),
                      )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  bool isFavourite(){
    myFav = sharedPreferences!.getStringList("favourite")!;

    // TODO: implement initState
    if(myFav.contains( widget.list['title'],)){
      return true;
    }
    return false;
  }
}
