import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'foods.dart';

// ignore: use_key_in_widget_constructors
class ReadData extends StatefulWidget {
  @override
  _ReadataState createState() => _ReadataState();
}

class _ReadataState extends State<ReadData> {
//  List<Foods> foods;

  Widget returnalldata() {
    return FutureBuilder<List>(
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
          // print('project snapshot data is: ${projectSnap.data}');
          return Container();
        }
        return ListView.builder(
          itemCount: projectSnap.data!.length,
          itemBuilder: (context, index) {
            Foods food = projectSnap.data![index];
            return Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                // ignore: prefer_const_literals_to_create_immutables
                // Widget to display the list of project
              ],
            );
          },
        );
      },
      future: Foods(
        title: 'null',
        ingredients: [],
        calories: null,
        image: "null",
        dishTypes: [],
        potassium_mg: null,
        alcohol_g: null,

      ).getAllFoods(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('show all foods'),
        ),
        body: Container(child: returnalldata()));
  }

  Future fetchAndSetList() async {
    final List<Foods> loadedList = [];

    await FirebaseFirestore.instance
        .collection("foods")
        .get()
        .then((QuerySnapshot snapshot) => snapshot.docs.forEach((f) => {
              loadedList.add(Foods(
                  title: f.get('title'),
                  calories: f.get('calories'),
                  image: f.get('image')))
            }));
    // print(loadedList.first.title);
    return loadedList;
  }
}
