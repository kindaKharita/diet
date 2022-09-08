import 'package:diet/firebase/user.dart';
import 'package:diet/utils/app_text_forms.dart';
import 'package:diet/utils/color.dart';
import 'package:diet/utils/form_text_type.dart';
import 'package:diet/widgets/bottom_bar.dart';
import 'package:diet/widgets/btn_widget.dart';
import 'package:diet/widgets/herder_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'info_user_page.dart';
import 'login_page.dart';

class RegPage extends StatefulWidget {
  @override
  _RegPageState createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> with TickerProviderStateMixin {
  TextEditingController emailU = new TextEditingController();
  TextEditingController passW = new TextEditingController();
  TextEditingController repassW = new TextEditingController();
  TextEditingController userName = new TextEditingController();

  GlobalKey<FormState> keySignIn1 = new GlobalKey<FormState>();

  GlobalKey<FormState> keySignIn2 = new GlobalKey<FormState>();
  GlobalKey<FormState> keySignIn3 = new GlobalKey<FormState>();
  GlobalKey<FormState> keySignIn4 = new GlobalKey<FormState>();

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
                HeaderContainer("Register", 0.3),
                Padding(padding: EdgeInsets.only(bottom: mqh * 0.07)),
                AppTextForms.registerTextForm(
                    keySignIn3,
                    context,
                    "FullName",
                    0.8,
                    100,
                    userName,
                    FormTextType.Field,
                    TextInputType.name, () {},''),
                Padding(padding: EdgeInsets.only(bottom: mqh * 0.01)),
                AppTextForms.registerTextForm(
                    keySignIn1,
                    context,
                    "Enter Email Address",
                    0.8,
                    100,
                    emailU,
                    FormTextType.Email,
                    TextInputType.emailAddress, () {},''),
                Padding(padding: EdgeInsets.only(bottom: mqh * 0.01)),
                AppTextForms.registerTextForm(
                    keySignIn2,
                    context,
                    "Enter Password",
                    0.8,
                    100,
                    passW,
                    FormTextType.Password,
                    TextInputType.visiblePassword, () {},''),
                Padding(padding: EdgeInsets.only(bottom: mqh * 0.01)),
                AppTextForms.registerTextForm(
                    keySignIn4,
                    context,
                    " Re Enter Password",
                    0.8,
                    100,
                    repassW,
                    FormTextType.RePassword,
                    TextInputType.visiblePassword, () {},passW.text.toString()),

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
                      // print(emailU.text);

                      // myUserApp=  Users('id', 'Rayan', 23, 1, 180, 65, 3,'');
                      // myUserApp!.email=emailU.text.toString();
                      // myUserApp!.name=userName.text.toString();
                      //
                      // print("email : "+  myUserApp!.email+'  name : ' + myUserApp!.name);
                      sharedPreferences!.remove('full_name');
                      sharedPreferences!.remove('email');
                      await sharedPreferences!.setString('full_name', userName.text);
                      await sharedPreferences!.setString('email', emailU.text);
                      await sharedPreferences!.setString('pass', passW.text);


                      try {
                        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: emailU.text.toString(),
                            password: passW.text.toString()
                        );
                      } on FirebaseAuthException catch (e) {
                        // if (e.code == 'weak-password') {
                        //   print('The password provided is too weak.');
                        if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        }
                      } catch (e) {
                        print(e);
                      }
                      // var name =await sharedPreferences!.getString('name');
                      // print(name);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InfoPage()));
                    },
                    // ignore: prefer_const_constructors
                    child: Text("Register",
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
                          "Log In",
                          style: TextStyle(fontSize: 14, color: colorhex),
                        ),
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
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

}
