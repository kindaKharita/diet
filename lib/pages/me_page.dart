import 'package:diet/app_function/app_func.dart';
import 'package:diet/app_function/update_data.dart';
import 'package:diet/pages/info_user_page_continue2.dart';
import 'package:diet/pages/loading_page.dart';
import 'package:diet/utils/app_text_forms.dart';
import 'package:diet/utils/color.dart';
import 'package:diet/utils/form_text_type.dart';
import 'package:diet/widgets/bottom_bar.dart';
import 'package:diet/widgets/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../main.dart';
import 'info_user_page_continue.dart';

class MePage extends StatefulWidget {
  String? profilePicture;

  var personanNoun;
  var email;
  var age;
  var wieght;
  var length;
  List<String> allergeName = [];
  List<String> propertyName = [];
  var active;
  double? calCurrent;
  double? calGoal;
  double? wChange;

  double? result;

  MePage(
      {this.profilePicture,
      this.personanNoun,
      this.email,
      this.calCurrent,
      this.calGoal});

  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  TextEditingController fullName = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController length = TextEditingController();

  GlobalKey<FormState> keySignIn1 = GlobalKey<FormState>();

  GlobalKey<FormState> keySignIn2 = GlobalKey<FormState>();
  GlobalKey<FormState> keySignIn3 = GlobalKey<FormState>();
  GlobalKey<FormState> keySignIn4 = GlobalKey<FormState>();

  @override
  void initState() {
    widget.personanNoun = sharedPreferences!.getString('full_name');
    widget.email = sharedPreferences!.getString('email');
    widget.age = sharedPreferences!.getString('age');
    widget.wieght = sharedPreferences!.getString('weight');
    widget.length = sharedPreferences!.getString('height');
    widget.calGoal = sharedPreferences!.getDouble('cal');

    widget.calCurrent = sharedPreferences!.getDouble('curr-cal');
    widget.allergeName = sharedPreferences!.getStringList('food_allergy')!;
    widget.propertyName = sharedPreferences!.getStringList('disease')!;
    widget.active = sharedPreferences!.getString('activity_lvl');
    widget.result = myUserApp!.percent();

    widget.wChange = widget.calGoal! - widget.calCurrent!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              children: <Widget>[
                _header(),
                const Padding(padding: EdgeInsets.all(5)),
                _progressBar(),
                const Padding(padding: EdgeInsets.all(5)),
                contaierInfoUser(),
                const Padding(padding: EdgeInsets.all(5)),
                containerActiveChange(),
                const Padding(padding: EdgeInsets.all(5)),
                containerDiseaseChange(),
                const Padding(padding: EdgeInsets.all(5)),
                containerAllergyChange(),
                const Padding(padding: EdgeInsets.all(5)),
                Container(
                  width: MediaQuery.of(context).size.width*0.8,
                  height: MediaQuery.of(context).size.height*0.05,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [colorhex, colorhex],
                          end: Alignment.bottomCenter,
                          begin: Alignment.topCenter),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(

                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => CustomDialog(
                          description:'cant add this sport, you reached to max burned calories',
                          buttonText: "Okay", logOut: true,
                        ),
                      );
                    },
                    // ignore: prefer_const_constructors
                    child: Text("Log Out",
                        style: TextStyle(color: Colors.white, fontSize: 14)),
                  ),
                ),
              ],
            ),
          ),
        )
        // bottomNavigationBar: BarBottom()
        );
  }

  Widget _header() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [colorhex, lightcolors],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter),
          borderRadius:
              const BorderRadius.only(bottomLeft: Radius.circular(100))),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 30,
            left: 70,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                  ),
                  child: widget.profilePicture != null
                      ? Image.asset(
                          'assets/' + widget.profilePicture!,
                          height: 70,
                          width: 70,
                        )
                      : const Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.black26,
                        ),
                )),
          ),
          Positioned(
              top: 45,
              left: 150,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.personanNoun,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      widget.email,
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ])),
        ],
      ),
    );
  }

  Widget _progressBar() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.white54),
          bottom: BorderSide(color: Colors.white54),
        ),
        color: Colors.white,
        // ignore: prefer_const_literals_to_create_immutables
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(3.0, 3.0),
            blurRadius: 5.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      height: MediaQuery.of(context).size.height * 0.37,
      child: ListView(
        padding: EdgeInsets.only(top: 5),
        children: [
          Container(
              padding: EdgeInsets.only(left: 20),
              alignment: Alignment.topLeft,
              child: const Text(
                "Progress :",
                style: TextStyle(color: Colors.black, fontSize: 16),
              )),
          // Padding(padding: const EdgeInsets.all(5)),
          // _progressBar(),
          SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                showLabels: false,
                showTicks: false,
                showFirstLabel: true,
                showLastLabel: true,
                startAngle: -200,
                //widget.wCurrent!>widget.wGoal!?widget.wCurrent:widget.wGoal,
                endAngle: -340,
                //widget.wCurrent<widget.wGoal!?widget.wCurrent:widget.wGoal,
                radiusFactor: 0.6,
                // canScaleToFit: true,
                axisLineStyle: AxisLineStyle(
                  thickness: 0.03,
                  color: Colors.grey,
                  thicknessUnit: GaugeSizeUnit.factor,
                  cornerStyle: CornerStyle.startCurve,
                ),
                pointers: <GaugePointer>[
                  RangePointer(
                    value: widget.result!,
                    width: 0.03,
                    color: colorhex,
                    sizeUnit: GaugeSizeUnit.factor,
                    // cornerStyle: CornerStyle.bothCurve
                  )
                ],
                annotations: [
                  GaugeAnnotation(
                    verticalAlignment: GaugeAlignment.center,
                    widget: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        // const Padding(padding: EdgeInsets.all(5)),
                        const Icon(
                          Icons.call_missed_outgoing_rounded,
                          color: Colors.black26,
                          size: 34.0,
                        ),
                        const Padding(padding: EdgeInsets.all(5)),
                        Text(
                          widget.result!.toStringAsFixed(3).toString() + " %",
                          style: TextStyle(
                              fontSize: 14,
                              color: widget.result! > 50.0
                                  ? Colors.green
                                  : Colors.red),
                        ),
                        const Padding(padding: EdgeInsets.all(5)),
                        Text(
                          'Current: ' + widget.calCurrent.toString() + ' cal',
                          style: const TextStyle(
                              fontSize: 12, color: Colors.black26),
                        ),
                        const Padding(padding: EdgeInsets.all(10)),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Expanded(
                                /// Start w
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(widget.calCurrent.toString()),
                                ),
                              ),
                              Expanded(
                                /// Start w
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(widget.calGoal.toString()),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///todo Active edit
  Widget containerActiveChange() {
    return Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.white54),
            bottom: BorderSide(color: Colors.white54),
          ),
          color: Colors.white,
          // ignore: prefer_const_literals_to_create_immutables
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(3.0, 3.0),
              blurRadius: 5.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        // height: MediaQuery.of(context).size.height *0.23,
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.only(left: 20, top: 5),
                alignment: Alignment.topLeft,
                child: const Text(
                  "Active  :",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                )),
            const Padding(padding: EdgeInsets.all(5)),
            Container(
                padding: const EdgeInsets.only(left: 30, top: 5),
                alignment: Alignment.topLeft,
                child: Text(
                  widget.active,
                  // 'kindaaaaaa',
                  style: const TextStyle(color: Colors.black26, fontSize: 16),
                )),
            const Padding(padding: EdgeInsets.all(10)),
            const Divider(height: 10),
            Container(
              height: 40,
              alignment: Alignment.bottomLeft,
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                InfoPageContinue(false, true, false)));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        'Change Active',
                        style: TextStyle(fontSize: 16, color: colorhex),
                      ),
                    ],
                  )),
            ),
          ],
        ));
  }

  ///todo Disease edit
  Widget containerDiseaseChange() {
    return Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.white54),
            bottom: BorderSide(color: Colors.white54),
          ),
          color: Colors.white,
          // ignore: prefer_const_literals_to_create_immutables
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(3.0, 3.0),
              blurRadius: 5.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        // height: MediaQuery.of(context).size.height *0.23,
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.only(left: 20, top: 5),
                alignment: Alignment.topLeft,
                child: const Text(
                  "Property  :",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                )),
            const Padding(padding: EdgeInsets.all(5)),
            for (int i = 0; i < widget.propertyName.length; i++)
              Container(
                  padding: const EdgeInsets.only(left: 30, top: 5),
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.propertyName[i],
                    style: const TextStyle(color: Colors.black26, fontSize: 16),
                  )),
            widget.propertyName.isEmpty
                ? Container(
                    padding: const EdgeInsets.only(left: 30, top: 5),
                    alignment: Alignment.topLeft,
                    child: const Text(
                      'Non Property',
                      style: TextStyle(color: Colors.black26, fontSize: 16),
                    ))
                : Container(),
            const Padding(padding: EdgeInsets.all(10)),
            const Divider(height: 10),
            Container(
              height: 40,
              alignment: Alignment.bottomLeft,
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                InfoPageContinue(false, false, true)));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        'Add Property',
                        style: TextStyle(fontSize: 16, color: colorhex),
                      ),
                    ],
                  )),
            ),
          ],
        ));
  }

  ///todo Allergy edit
  Widget containerAllergyChange() {
    return Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.white54),
            bottom: BorderSide(color: Colors.white54),
          ),
          color: Colors.white,
          // ignore: prefer_const_literals_to_create_immutables
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(3.0, 3.0),
              blurRadius: 5.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        // height: MediaQuery.of(context).size.height *0.23,
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.only(left: 20, top: 5),
                alignment: Alignment.topLeft,
                child: const Text(
                  "Allergy  :",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                )),
            const Padding(padding: EdgeInsets.all(5)),
            for (int i = 0; i < widget.allergeName.length; i++)
              Container(
                  padding: const EdgeInsets.only(left: 30, top: 5),
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.allergeName[i],
                    style: const TextStyle(color: Colors.black26, fontSize: 16),
                  )),
            widget.allergeName.isNotEmpty
                ? Container()
                : Container(
                    padding: const EdgeInsets.only(left: 30, top: 5),
                    alignment: Alignment.topLeft,
                    child: const Text(
                      'Non Allergy',
                      style: TextStyle(color: Colors.black26, fontSize: 16),
                    )),
            const Padding(padding: EdgeInsets.all(10)),
            const Divider(height: 10),
            Container(
              height: 40,
              alignment: Alignment.bottomLeft,
              child: TextButton(
                  onPressed: () {
                    // print(listAllergy);
                    if (listAllergy == null || listAllergy!.isEmpty) {
                      AppFunction().initAllergyList(context);
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => listAllergy != null
                                ? InfoPageContinue2(false)
                                : LoadingPage()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        'Add Allergy',
                        style: TextStyle(fontSize: 16, color: colorhex),
                      ),
                    ],
                  )),
            ),
          ],
        ));
  }

  ///todo info User edit
  Widget contaierInfoUser() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.white54),
          bottom: BorderSide(color: Colors.white54),
        ),
        color: Colors.white,
        // ignore: prefer_const_literals_to_create_immutables
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(3.0, 3.0),
            blurRadius: 5.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      // height: MediaQuery.of(context).size.height *0.23,
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.only(left: 20, top: 5),
              alignment: Alignment.topLeft,
              child: const Text(
                "Information  ",
                style: TextStyle(color: Colors.black, fontSize: 16),
              )),
          const Padding(padding: EdgeInsets.all(10)),
          Container(
              padding: const EdgeInsets.only(left: 20),
              alignment: Alignment.topLeft,
              child: const Text(
                "Name :",
                style: TextStyle(color: Colors.black, fontSize: 14),
              )),
          AppTextForms.registerTextForm(
              keySignIn1,
              context,
              widget.personanNoun,
              0.8,
              0.1,
              fullName,
              FormTextType.Noun,
              TextInputType.name,
              () {},
              ''),
          Container(
              padding: const EdgeInsets.only(left: 20),
              alignment: Alignment.topLeft,
              child: const Text(
                "Age :",
                style: TextStyle(color: Colors.black, fontSize: 14),
              )),
          AppTextForms.registerTextForm(keySignIn2, context, widget.age, 0.8, 5,
              age, FormTextType.Noun, TextInputType.name, () {}, ''),
          Container(
              padding: const EdgeInsets.only(left: 20),
              alignment: Alignment.topLeft,
              child: const Text(
                "Weight :",
                style: TextStyle(color: Colors.black, fontSize: 14),
              )),
          AppTextForms.registerTextForm(keySignIn3, context, widget.wieght, 0.8,
              10, weight, FormTextType.Noun, TextInputType.name, () {}, ''),
          Container(
              padding: const EdgeInsets.only(left: 20),
              alignment: Alignment.topLeft,
              child: const Text(
                "Length :",
                style: TextStyle(color: Colors.black, fontSize: 14),
              )),
          AppTextForms.registerTextForm(keySignIn4, context, widget.length, 0.8,
              10, length, FormTextType.Noun, TextInputType.name, () {}, ''),
          const Divider(height: 10),
          Container(
            height: 40,
            alignment: Alignment.bottomLeft,
            child: TextButton(
                onPressed: () {
                  // ignore: unrelated_type_equality_checks, unnecessary_null_comparison
                  if (fullName.text.isNotEmpty || fullName != ' ') {
                    UpdateData().updateName(fullName.text.toString());
                    setState(() {
                      widget.personanNoun = fullName.text;
                    });
                  }
                  if (age.text.isNotEmpty) {
                    UpdateData().updateAge(age.text.toString());
                  }
                  if (weight.text.isNotEmpty) {
                    UpdateData().updateWeight(weight.text.toString());
                    setState(() {
                      AppFunction().initBeforAllergyList(context);
                      AppFunction().initSportList();
                    });
                  }
                  if (length.text.isNotEmpty) {
                    UpdateData().updateLength(length.text.toString());
                  }
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => BottomBarPage(4)));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      'Update Info',
                      style: TextStyle(fontSize: 16, color: colorhex),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  ///todo weight change
// Widget containerInfoWC() {
//   return Container(
//     decoration: const BoxDecoration(
//       border: Border(
//         top: BorderSide(color: Colors.white54),
//         bottom: BorderSide(color: Colors.white54),
//       ),
//       color: Colors.white,
//       // ignore: prefer_const_literals_to_create_immutables
//       boxShadow: [
//         BoxShadow(
//           color: Colors.grey,
//           offset: Offset(3.0, 3.0),
//           blurRadius: 5.0,
//           spreadRadius: 2.0,
//         ),
//       ],
//     ),
//     height: MediaQuery.of(context).size.height * 0.23,
//     child: Column(
//       children: [
//         Container(
//             padding: const EdgeInsets.only(left: 20, top: 5),
//             alignment: Alignment.topLeft,
//             child: const Text(
//               "Goals :",
//               style: TextStyle(color: Colors.black, fontSize: 16),
//             )),
//         const Padding(padding: EdgeInsets.all(10)),
//
//         Container(
//             padding: const EdgeInsets.only(left: 20),
//             alignment: Alignment.topLeft,
//             child: const Text(
//               "Daily Calories ",
//               style: TextStyle(color: Colors.black54, fontSize: 14),
//             )),
//         Container(
//           padding: const EdgeInsets.only(left: 25),
//           alignment: Alignment.topLeft,
//           child: Text(
//             widget.calories.toString() + " Cal ",
//             style: TextStyle(color: Colors.black, fontSize: 16),
//           ),
//         ),
//         Container(
//
//             padding: const EdgeInsets.only(left: 25),
//             alignment: Alignment.topLeft,
//             child: const Text(
//               "cain 0.5 kg per weak ",
//               style: TextStyle(color: Colors.black54, fontSize: 14),
//             )),
//         const Padding(padding: EdgeInsets.all(10)),
//         const Divider(height: 10),
//         Container(
//           height: 40,
//           alignment: Alignment.bottomLeft,
//           child: TextButton(
//               onPressed: () {},
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 // ignore: prefer_const_literals_to_create_immutables
//                 children: [
//                   Text(
//                     'Update Goals',
//                     style: TextStyle(fontSize: 16, color: colorhex),
//                   ),
//                 ],
//               )),
//         ),
//       ],
//     ),
//   );
// }
}
