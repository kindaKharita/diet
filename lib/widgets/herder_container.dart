import 'package:diet/utils/color.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HeaderContainer extends StatelessWidget {
  var text = "Login";
  double size = 0.3;

  // ignore: use_key_in_widget_constructors
  HeaderContainer(this.text, this.size);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height * size,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [colorhex, lightcolors],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter),
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(100))),
      child: Stack(
        children: <Widget>[

          Positioned(
              bottom: 20,
              right: 20,
              child: Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              )),
          // Center(
          // child: Image.asset("assets/index.png"),
          //),
        ],
      ),
    );
  }
}
