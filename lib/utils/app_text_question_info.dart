import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class Question extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var question;
  // ignore: use_key_in_widget_constructors
  Question({this.question});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      alignment: Alignment.centerLeft,
      child: Text(
        question,
      ),
    );
  }
}
