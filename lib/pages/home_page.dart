import 'dart:async';

import 'package:diet/app_function/app_func.dart';
import 'package:diet/firebase/user.dart';
import 'package:diet/main.dart';
import 'package:diet/pages/admin_add_food.dart';
import 'package:diet/pages/information_food.dart';
import 'package:diet/utils/color.dart';
import 'package:diet/widgets/card_food.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:decorative_app_bar/decorative_app_bar.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  List listCopy1 = [];

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  TextEditingController dateinput = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? address;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  String? _fileName;
  String? _saveAsFileName;
  List<PlatformFile>? _paths;
  String? _directoryPath;
  String? _extension;
  bool _isLoading = false;
  bool _userAborted = false;
  bool _multiPick = false;
  String wordSearch="";
  FileType _pickingType = FileType.image;
  TextEditingController _controller = TextEditingController();
  void initState() {
    //TODO init rec food
    AppFunction().fetchRecFood();
    Timer(const Duration(milliseconds: 500), () {
      initCopyList();
    });



    super.initState();
  }

  void initCopyList() {
    myFav = sharedPreferences!.getStringList('favourite')!;

    // print(myUserApp!.favourite);
    for (int i = 0; i < allRecFoods!.length; i++) {
      if (!myFav.contains(allRecFoods![i]['title'])) {
        widget.listCopy1.add(allRecFoods![i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Stack(
              children: [
                DecorativeAppBar(
                  barHeight: MediaQuery
                      .of(context)
                      .size
                      .height * 0.22,
                  barPad: MediaQuery
                      .of(context)
                      .size
                      .height * 0.15,
                  radii: 100,
                  background: Colors.white,
                  gradient1: colorhex,
                  gradient2: colorhex,
                  extra: Positioned(
                    top: 60,
                    right: 175,
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Home',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ),
                ),
                myUserApp!.email.endsWith('diet.com')
                    ? Positioned(
                  top: MediaQuery
                      .of(context)
                      .size
                      .height * 0.16,
                  right: MediaQuery
                      .of(context)
                      .size
                      .width * 0.3,
                  child: Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.04,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.6,
                    alignment: Alignment.center,
                    // color: colorhex,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [colorhex, colorhex],
                            end: Alignment.bottomCenter,
                            begin: Alignment.topCenter),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddFoodAdmin()));
                      },
                      // ignore: prefer_const_constructors
                      child: Text("Add Food",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14)),
                    ),
                  ),
                )
                    : Positioned(
                    top: MediaQuery
                        .of(context)
                        .size
                        .height * 0.16,
                    right: MediaQuery
                        .of(context)
                        .size
                        .width * 0.62,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
                            'Welcome To',
                            style:
                            TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          const Text(
                            'Healthy Diet',
                            style: TextStyle(
                                fontSize: 18, color: Colors.black),
                          )
                        ],
                      ),
                    )),
                Positioned(
                    top: MediaQuery
                        .of(context)
                        .size
                        .height * 0.16,
                    right: MediaQuery
                        .of(context)
                        .size
                        .width * 0.1,
                    child: Row(
                      children: [
                        Container(
                            child: IconButton(
                              onPressed: () async {
                                setState(() {
                                  widget.listCopy1 = [];
                                  initCopyList();
                                });
                                print(myUserApp!.plan_date);
                                print(DateTime.now().day);
                                // Users temp = Users(
                                //     'id',
                                //     'rayan',
                                //     23,
                                //     1,
                                //     180,
                                //     60,
                                //     2,
                                //     'rayan@gmail.com');
                                // List<dynamic> resUser;
                                // resUser = await temp.getUser('ayman@gmail.com');
                                // print('136 homepage');
                                // print(resUser.toString() + "wowoowo");
                                // print(myUserApp!.weight);
                                // // AppFunction().setSharedPrefernce(resUser);
                                //
                                // myUserApp = AppFunction().getAllInfoUsre();
                              },
                              icon: const Icon(Icons.refresh),
                            )
                        ),
                        Container(
                            child: IconButton(
                              onPressed: () async {
                                Navigator.pushReplacement(
                                    context, MaterialPageRoute(builder: (context) => InformationFood(list: null,)));
                              },
                              icon: const Icon(Icons.camera),
                            )
                        ),
                      ],
                    )
                ),
              ],
            ),
            Expanded(
              flex: 1,
              child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: ListView(
                    children: [
                      for (int i = 0; i < widget.listCopy1.length; i++)
                        CardFoodList(widget.listCopy1[i], 0.4, 1, false),
                    ],
                  )),
            ),
          ],
        ));
  }
  void _resetState() {
    _isLoading = true;
    _directoryPath = null;
    _fileName = null;
    _paths = null;
    _saveAsFileName = null;
    _userAborted = false;
  }

  void _logException(String message) {
    print(message);
    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> _pickFiles() async {
    _resetState();
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    }
    _isLoading = false;
    _fileName =
    _paths != null ? _paths!.map((e) => e.name).toString() : '...';
    _userAborted = _paths == null;
    // imageSearch = _fileName!;
  }


}
// Positioned(
// top: 115,
// right: 50,
// child:Container(
// height: MediaQuery.of(context).size.height*0.04,
// width: MediaQuery.of(context).size.width*0.8,
// alignment: Alignment.center,
// child: TextFormField(
// decoration:  InputDecoration(
// // filled: true,
// fillColor: Colors.grey[200],
// suffix:  IconButton( onPressed: () {
//
// }, icon: Icon(Icons.search),),
// contentPadding: EdgeInsets.all(3),
// hintText: "Search Food",
// // border: InputBorder.none,
// focusedBorder:  OutlineInputBorder(
// borderRadius: BorderRadius.circular(60),
// borderSide: BorderSide(style: BorderStyle.none),
// ),
// enabledBorder: OutlineInputBorder(
// borderRadius: BorderRadius.circular(80),
// borderSide: BorderSide(style: BorderStyle.none),
// ),
// // errorBorder: InputBorder.none,
// // disabledBorder: InputBorder.none,
//
// ),
// ),
// )
// ),
