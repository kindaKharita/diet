import 'package:connectivity/connectivity.dart';
import 'package:diet/firebase/allergy.dart';
import 'package:diet/firebase/foods.dart';
import 'package:diet/firebase/user.dart';
import 'package:diet/main.dart';
import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {


  bool isConnected = false;
  Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    isConnected = connectivityResult != ConnectivityResult.none;
    return isConnected;
  }




  final Allergy _allergy = Allergy(food: '', allergy: '');

  Allergy get allergy => _allergy;


  late List _listAllFoodBeforAllergy;


  List get listAllFoodBeforAllergy => _listAllFoodBeforAllergy;


  set listAllFoodBeforAllergy(List list) {
    _listAllFoodBeforAllergy = list;
    notifyListeners();
  }

  Future<List> allFoodBeforFiltterlAllergyList() async {
    //TODO add firebase write and read from collection
    // Allergy allergy = Allergy(food: "null", allergy: "null");
    Foods foo =  Foods(
      title: '',
      image: '',
      vegetarian: false,
      alcohol_g: 0,
      potassium_mg: 0,
      calories: 0,
      dishTypes: [],
      ingredients: [],
    );
    _listAllFoodBeforAllergy= await foo.getAllFoods();
    //_listAllFoodBeforAllergy = await allergy.getFilteredData();



    return _listAllFoodBeforAllergy;
  }


//   List allFoodAftterFiltterlAllergyList() {
// print('asdfghjl');
//     _listAllFoodBeforAllergy =  allergy.getFilteredData();
//     return _listAllFoodBeforAllergy;
//   }
  late List _listAllAllergy;


  List get listAllAllergy => _listAllAllergy;


  set listAllAllergy(List list) {
    _listAllAllergy = list;
    notifyListeners();
  }



  Future<List> allAllergyList() async {
    //TODO add firebase write and read from collection
    _listAllAllergy = await allergy.getAllAllergies();



    return _listAllAllergy;
  }



  Foods food = Foods();
  late List _listcal;

  List get listcal =>_listcal;

  set listcal(List list){
    _listcal=list;
    notifyListeners();
  }
  Future<List> filterCalories(double cal,List list) async {

    Foods food = Foods();
    // ignore: avoid_print
  
    _listcal = food.filterCalories(list, cal);





    return _listcal;
  }


  late List _listDishType;

  List get listDishType =>_listDishType;

  set listDishType(List list){
    _listDishType=list;
    notifyListeners();
  }


  Future<List> filterDishTypeList(String dishTypeName,List list) async {

    _listDishType = food.filterDishTypes(list, dishTypeName);
    print(_listDishType);
    // List list2 = food.filterNoAlcohol(list1);

    // _listCaloriesFood.forEach((element) {
    //   print('${element['title']}' + ' : ' + '${element['alcohol_g']}');
    // });
    //
    // food.sortBy(_listCaloriesFood, 'alcohol_g');
    // _listCaloriesFood.reversed.forEach((element) {
    //   print('after sort: \t ' +
    //       '${element['title']}' +
    //       ' : ' +
    //       '${element['alcohol_g']}');
    // });
    //
    //
    // List list2 = food.filterVegetarian(_listCaloriesFood);
    // list2.forEach((element) {
    //   print('${element['title']}' + ' : ' + '${element['vegetarian']}');
    // });
    // print("Vegan..");
    //
    // food.filterPotassium(_listCaloriesFood);
    // print('${food.title}' + ' : ' + '${food.potassium_mg}');
    //
    // print("Potassium...");
    // //to read a title of food
    // // print('${list.last['food']}');
    //
    // // print('${list.length}');
    //
    // // print('${list.last['allergy']}');
    //
    // //to read a specific ingredient
    // //print('${list[0]['ingredients'][1]}');
    //
    // // setState(() {
    // //   // _counter++;
    // // });

    return _listDishType;
  }

  void printAllAllergyList(){
    print("after allergy...");

    for (int i = 0; i < _listAllAllergy.length; i++) {
      print('${_listAllAllergy[i]['title']}' + ':' + '${_listAllAllergy[i]['calories']}');
    }

  }

}



  // late List _listCaloriesFood;
  //
  //
  // List get listCaloriesFood  =>_listCaloriesFood;
  //
  //
  // set listCaloriesFood( List list){
  //   _listCaloriesFood=list;
  //   notifyListeners();
  // }
  //





//   Future<List> filterCaloeiesList() async {
//
//     Foods food = Foods();
//     // ignore: avoid_print
//     print('after calories...');
//     _listCaloriesFood = food.filterCalories(_listAllAllergy, 400);
//     for (int i = 0; i < _listCaloriesFood.length; i++) {
//       print('${_listCaloriesFood[i]['title']}' +
//           ' : ' +
//           '${_listCaloriesFood[i]['calories']}' +
//           ' : ' +
//           '${_listCaloriesFood[i]['dishTypes']}');
//     }
//
//
//
//     //List list2 = food.filterDishTypes(list1, 'lunch');
//     // List list2 = food.filterNoAlcohol(list1);
//
//     _listCaloriesFood.forEach((element) {
//       print('${element['title']}' + ' : ' + '${element['alcohol_g']}');
//     });
//
//     food.sortBy(_listCaloriesFood, 'alcohol_g');
//     _listCaloriesFood.reversed.forEach((element) {
//       print('after sort: \t ' +
//           '${element['title']}' +
//           ' : ' +
//           '${element['alcohol_g']}');
//     });
//
//
//     List list2 = food.filterVegetarian(_listCaloriesFood);
//     list2.forEach((element) {
//       print('${element['title']}' + ' : ' + '${element['vegetarian']}');
//     });
//     print("Vegan..");
//
//     food.filterPotassium(_listCaloriesFood);
//     print('${food.title}' + ' : ' + '${food.potassium_mg}');
//
//     print("Potassium...");
//     //to read a title of food
//     // print('${list.last['food']}');
//
//     // print('${list.length}');
//
//     // print('${list.last['allergy']}');
//
//     //to read a specific ingredient
//     //print('${list[0]['ingredients'][1]}');
//
//     // setState(() {
//     //   // _counter++;
//     // });
//
//     return _listCaloriesFood;
//   }
//
//   void printAllAllergyList(){
//     print("after allergy...");
//
//     for (int i = 0; i < _listAllAllergy!.length; i++) {
//       print('${_listAllAllergy[i]['title']}' + ':' + '${_listAllAllergy[i]['calories']}');
//     }
//
//   }
//
// }