import 'package:diet/app_function/app_func.dart';
import 'package:diet/firebase/allergy.dart';
import 'package:diet/main.dart';
import 'package:diet/pages/diary.dart';
import 'package:diet/pages/home_page.dart';
import 'package:diet/pages/me_page.dart';
import 'package:diet/pages/plan_page.dart';
import 'package:diet/pages/recipes.dart';
import 'package:diet/provider/app_filtter_list_provider.dart';
import 'package:diet/utils/app_name_list_food.dart';
import 'package:diet/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class BottomBarPage extends StatefulWidget {
  // List listAllergy;
  // // ignore: use_key_in_widget_constructors
  // BottomBarPage({required this.listAllergy});
  int currentIndex = 2;

  BottomBarPage(this.currentIndex);
  @override
  _BottomBarPageState createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {


  // ignore: deprecated_member_use
  List<Widget> _pages =<Widget>[];
    @override
  void initState()   {


      List<String>? list = sharedPreferences!.getStringList("food_allergy");

      AppFunction().initBeforAllergyList(context);
      AppFunction().initSportList();

    _pages.add(DiaryPage());
    _pages.add(RecipesPage(listCopy: listFoodAfterFilterAllergy!,namePage: NameListFood.recipes,));
    _pages.add(HomePage());
    _pages.add(PlanFood());
    _pages.add(MePage());
    super.initState();
  }
  // void initListAllergy() async{
  //   listAllergy=await Provider.of<AppProvider>(context,
  //       listen: false).allAllergyList();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[widget.currentIndex],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
          child: BottomNavigationBar(
              showSelectedLabels: true,
              showUnselectedLabels: true,
              backgroundColor: Colors.white,
              selectedItemColor: colorhex,
              currentIndex: widget.currentIndex,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                // if(myUserApp!.checkCompletePlan()=='plan Completed'){
                //   isCompletePlan=true;
                // }else{
                //   isCompletePlan=false;
                // }
                if(myUserApp!.calories==-500){
                  AppFunction().getAllInfoUsre();
                }
                setState(() {
                  widget.currentIndex = index;
                });

              },
              // ignore: prefer_const_literals_to_create_immutables
              items: [
                const BottomNavigationBarItem(
                    // ignore: deprecated_member_use
                    icon: Icon(Icons.note_add_outlined), label:'Diary'),
                const BottomNavigationBarItem(
                    // ignore: deprecated_member_use
                    icon: Icon(Icons.favorite_outline), label: 'Favourite'),
                const BottomNavigationBarItem(
                    // ignore: deprecated_member_use
                    icon: Icon(Icons.home_outlined), label:''),
                const BottomNavigationBarItem(
                    // ignore: deprecated_member_use
                    icon: Icon(Icons.next_plan_outlined), label: 'Plans'),
                const BottomNavigationBarItem(
                    // ignore: deprecated_member_use
                    icon: Icon(Icons.person_outlined), label: 'Me')
              ]),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,

      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: widget.currentIndex == 2 ? colorhex : Colors.white54,
          child:  Icon(Icons.home_outlined,color: widget.currentIndex == 2 ? Colors.white:Colors.grey,),
          onPressed: () => setState(() {
            widget.currentIndex = 2;
          }),
        ),
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors





