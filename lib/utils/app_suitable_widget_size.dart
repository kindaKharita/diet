import 'package:flutter/material.dart';
class AppSuitableWidgetSize {
  // It's the AdobeXD Device Height
  double targetHeightSize = 926;

  // It's the AdobeXD Device Width
  double targetWidthSize = 428;

  double getSuitableWidgetHeight(
      double targetWidgetHeight, BuildContext context) {
    var physicalPixelHeight = MediaQuery.of(context).size.height *
        MediaQuery.of(context).devicePixelRatio;
    //print("devicePixelRatio: " +
    //   MediaQuery.of(context).size.aspectRatio.toString());
    // print("physicalPixelHeight: " + physicalPixelHeight.toString());

    if (MediaQuery.of(context).size.aspectRatio > 0.463) {
      targetHeightSize = 736;
      return (MediaQuery.of(context).size.height * targetWidgetHeight * 0.85) /
          this.targetHeightSize;
    } else {
      targetHeightSize = 896;

      return (MediaQuery.of(context).size.height * targetWidgetHeight) /
          this.targetHeightSize; // It's the AdobeXD Device Width

    }
  }

  double getSuitableWidgetWidth(
      double targetWidgetWidth, BuildContext context) {
    if (MediaQuery.of(context).size.aspectRatio > 0.463)
      targetWidthSize = 414;
    else
      targetWidthSize = 428;

    return (MediaQuery.of(context).size.width * targetWidgetWidth) /
        this.targetWidthSize;
  }
}

final appWidgetSizer = AppSuitableWidgetSize();
