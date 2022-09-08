import 'package:diet/pages/splash_page.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class CustomDialog extends StatelessWidget {
  String description, buttonText;
  bool logOut = false;

  CustomDialog({
    required this.description,
    required this.buttonText,
    required this.logOut,
    // this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[

        Container(
          padding: const EdgeInsets.only(
            top: Consts.avatarRadius + Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: const EdgeInsets.only(top: Consts.avatarRadius),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              const BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 24.0),
              // Align(
              //   alignment: Alignment.bottomRight,
              //   child: FlatButton(
              //     onPressed: () {
              //       if (logOut) {
              //         sharedPreferences!.clear();
              //         Navigator.pushReplacement(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (context) => SplashPage()));
              //       }
              //       else {
              //         Navigator.of(context).pop();
              //       }
              //       // To close the dialog
              //     },
              //     child: Text(buttonText),
              //   ),
              // ),
              // Align(
              //   alignment: Alignment.bottomLeft,
              //   child: FlatButton(
              //     onPressed: () {
              //       Navigator.of(context).pop();
              //       // To close the dialog
              //     },
              //     child: const Text('Cancel'),
              //   ),
              // ),
            ],
          ),
        ),
        logOut ? Container() : Positioned(
          left: Consts.padding,
          right: Consts.padding,
          child: CircleAvatar(
            backgroundColor: description == "plan Completed"
                ? Colors.green
                : Colors.red,
            child: Icon(description == "plan Completed" ? Icons.check : Icons
                .error_outline, size: 50, color: Colors.black,),
            radius: Consts.avatarRadius,
          ),
        ),
      ],
    );
  }

}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 50.0;
}
