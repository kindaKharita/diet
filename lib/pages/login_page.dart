import 'package:diet/app_function/app_func.dart';
import 'package:diet/firebase/user.dart';
import 'package:diet/main.dart';
import 'package:diet/pages/register_page.dart';
import 'package:diet/utils/app_text_forms.dart';
import 'package:diet/utils/color.dart';
import 'package:diet/utils/form_text_type.dart';
import 'package:diet/widgets/bottom_bar.dart';
import 'package:diet/widgets/herder_container.dart';
import 'package:diet/widgets/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:diet/pages/login_page.dart';
import 'package:diet/widgets/bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailU = new TextEditingController();
  TextEditingController passW = new TextEditingController();
  GlobalKey<FormState> keySignIn1 = new GlobalKey<FormState>();
  GlobalKey<FormState> keySignIn2 = new GlobalKey<FormState>();
  double mqh = 0;
  double mqw = 0;

  @override
  Widget build(BuildContext context) {
    mqh = MediaQuery
        .of(context)
        .size
        .height;
    mqw = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      // backgroundColor: colorBlue1,
      body: SingleChildScrollView(

        // height: MediaQuery.of(context).size.height,
          child: Container(
            // height: mqh,
            width: mqw,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HeaderContainer("Login", 0.3),
                Padding(padding: EdgeInsets.only(bottom: mqh * 0.07)),
                // ContainerOP(lebelTextOP: "Enter Email Address",controllerForm: emailU,keySignIn: keySignIn1,pass: false,valid: validateEmail,),
                AppTextForms.registerTextForm(
                    keySignIn1,
                    context,
                    "Enter Email Address",
                    0.8,
                    100,
                    emailU,
                    FormTextType.Email,
                    TextInputType.emailAddress, () {},
                    ''),
                Padding(padding: EdgeInsets.only(bottom: mqh * 0.01)),
                // ContainerOP(lebelTextOP: "Enter Password",controllerForm: passW,keySignIn: keySignIn2,pass: true,valid: validatePass,),
                AppTextForms.registerTextForm(
                    keySignIn2,
                    context,
                    "Enter Password",
                    0.8,
                    100,
                    passW,
                    FormTextType.Password,
                    TextInputType.visiblePassword, () {},
                    ''),
                // Padding(padding: EdgeInsets.only(bottom: mqh*0.01)),
                Container(
                    height: mqh * 0.03,
                    padding: EdgeInsets.only(right: mqw * 0.1),
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      // ignore: prefer_const_constructors
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      onTap: () {

                      },
                    )
                ),
                Padding(padding: EdgeInsets.only(bottom: mqh * 0.1)),
                Container(
                  width: mqw * 0.8,
                  height: mqh * 0.08,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [colorhex, colorhex],
                          end: Alignment.bottomCenter,
                          begin: Alignment.topCenter),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(

                    onPressed: () async {
                      AppFunction().initBeforAllergyList(context);
                      String isFound = await authUser(
                          emailU.text.toString(), passW.text.toString());
                      print(isFound);
                      if (isFound == 'true') {
                        getUserEmail();

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomBarPage(2)));
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              CustomDialog(
                                description: isFound,
                                buttonText: "Okay", logOut: false,
                              ),
                        );
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      }
                    },
                    // ignore: prefer_const_constructors
                    child: Text("Log In",
                        style: TextStyle(color: Colors.white, fontSize: 14)),
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: mqh * 0.1)),
                Container(
                  alignment: Alignment.center,
                  height: mqh * 0.03,
                  width: mqw * 0.65,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account ?",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      InkWell(
                        child: Text(
                          "Register",
                          style: TextStyle(fontSize: 14, color: colorhex),
                        ),
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegPage()));
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  height: mqh * 0.0001,
                ),
              ],
            ),
          )
      ),
    );
  }

  Future<String> authUser(String emailUser, String passUser) async {
    UserCredential userCredential;
    try {
      userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: emailUser,
          password: passUser
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return 'No user found for that email.';
        // return LoginPage();
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return 'Wrong password provided for that user.';
        // return Container(
        //   child: Text('Text'),
        // );
      }
    }
    return 'true';
  }

  void getUserEmail() async {
    // var chk=await authUser(emailU.text.toString(), passW.text.toString());
    // if(chk){
    Users temp = Users(
        'id',
        'rayan',
        23,
        1,
        180,
        60,
        2,
        'rayan@gmail.com');
    List<dynamic> resUser;
    resUser = await temp.getUser(emailU.text.toString());
    print(resUser);
    AppFunction().setSharedPrefernce(resUser);
    AppFunction().getAllInfoUsre();
    myUserApp!.getCaloriesChange();
    // print(resUser.first['food_allergy']);
    // }
  }
}
