
import 'package:diet/pages/splash_page.dart';
import 'package:diet/provider/app_filtter_list_provider.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase/user.dart';

List ?listFoodAfterFilterAllergy;
List ?allFoods;
List ?allRecFoods;
List<String> myFav= [];
List<String> dishTypeFood= [];
List<String> sportName= [];
List ?allSports;
// List<String> dishTypeFoodLunch= [];
Users ?myUserApp;
List ?listAllergy;
bool isCompletePlan=false;

SharedPreferences ?sharedPreferences;

void main() async {

  // sharedPreferences =await SharedPreferences.getInstance();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  sharedPreferences =await SharedPreferences.getInstance();

  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (BuildContext context) => AppProvider(),
            ),
          ],
          child:MyApp()
  )
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: Consumer<AppProvider>(
        builder: (context, appProvider, child) {
          return MaterialApp(
              home: FutureBuilder(
                future: Firebase.initializeApp(),
                builder: (context, snapshot){
                  _incrementCounter(context);

                  if (snapshot.hasError) {
                    print('you have an error! ${snapshot.error.toString()} ');
                    return const Text('something wrong!');
                  } else if (snapshot.hasData) {

                      return SplashPage();
                    // }
                  } else {
                    return const Center(
                        child: const CircularProgressIndicator());
                  }
                },
              )
            // MyHomePage(title: 'Flutter Home'),
          );
        },
      ),
    );
  }


  Future<void> _incrementCounter(BuildContext context) async {




  }



}

