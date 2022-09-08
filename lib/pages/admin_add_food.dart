import 'package:diet/app_function/item_ui_radio.dart';
import 'package:diet/firebase/foods.dart';
import 'package:diet/utils/app_text_forms.dart';
import 'package:diet/utils/color.dart';
import 'package:diet/utils/form_text_type.dart';
import 'package:diet/widgets/pickar_viwe.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class AddFoodAdmin extends StatefulWidget {
  @override
  _AddFoodAdminState createState() => _AddFoodAdminState();
}

class _AddFoodAdminState extends State<AddFoodAdmin> {
  GlobalKey<FormState> keySignIn1 = GlobalKey<FormState>();

  GlobalKey<FormState> keySignIn2 = GlobalKey<FormState>();
  GlobalKey<FormState> keySignIn3 = GlobalKey<FormState>();
  GlobalKey<FormState> keySignIn4 = GlobalKey<FormState>();
  GlobalKey<FormState> keySignIn5 = GlobalKey<FormState>();
  GlobalKey<FormState> keySignIn6 = GlobalKey<FormState>();
  GlobalKey<FormState> keySignIn7 = GlobalKey<FormState>();
  GlobalKey<FormState> keySignIn8 = GlobalKey<FormState>();
  GlobalKey<FormState> keySignIn9 = GlobalKey<FormState>();
  GlobalKey<FormState> keySignIn10 = GlobalKey<FormState>();
  GlobalKey<FormState> keySignIn11 = GlobalKey<FormState>();
  GlobalKey<FormState> keySignIn12 = GlobalKey<FormState>();
  GlobalKey<FormState> keySignIn13 = GlobalKey<FormState>();
  GlobalKey<FormState> keySignIn14 = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController alcohol_g = TextEditingController();
  TextEditingController carbohydrates_g = TextEditingController();
  TextEditingController calcium_mg = TextEditingController();
  TextEditingController calories = TextEditingController();
  TextEditingController cholesterol_mg = TextEditingController();
  TextEditingController fat_g = TextEditingController();
  TextEditingController fiber_g = TextEditingController();
  TextEditingController health_score = TextEditingController();
  TextEditingController per_carbs = TextEditingController();
  TextEditingController per_fat = TextEditingController();
  TextEditingController per_protein = TextEditingController();
  TextEditingController potassium_mg = TextEditingController();
  TextEditingController protein_g = TextEditingController();
  TextEditingController vit_c_mg = TextEditingController();
  List<TextEditingController> ingredents = [];
  List<Item> listDishType = <Item>[
    Item(name: 'breakfast'),
    Item(name: 'lunch'),
    Item(name: 'dinner'),
    Item(name: 'snack'),
    Item(name: 'appetizers'),
  ];

  List ingredientsFood = [];
  int lenIng = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Food'),
          backgroundColor: colorhex,
          actions: [
            IconButton(
                onPressed: () {
                  // showSearch(context: context, delegate: DataSearch());
                },
                icon: const Icon(Icons.more_vert))
          ],
          elevation: 10,
          // leading:   IconButton(onPressed: (){}, icon: Icon(Icons.mo),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                allTextFormInfoFood(),
                showDishType(),
                ingredientForm(),
                const Padding(padding: EdgeInsets.all(10)),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.04,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [colorhex, colorhex],
                          end: Alignment.bottomCenter,
                          begin: Alignment.topCenter),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                    onPressed: () async {
                      List<String> listIng = [];
                      for (int i = 0; i < lenIng; i++) {
                        listIng[i] = ingredents[i].text.toString();
                      }
                      List<String> list =
                          sharedPreferences!.getStringList("dishType")!;
                      Foods newFood = Foods(
                        title: title.text,
                        alcohol_g: double.parse(alcohol_g.text.toString()),
                        calories: double.tryParse(calories.text.toString()),
                        carbohydrates_g:
                            double.tryParse(carbohydrates_g.text.toString()),
                        cholesterol_mg:
                            double.tryParse(cholesterol_mg.text.toString()),
                        per_carbs: double.tryParse(per_carbs.text.toString()),
                        per_fat: double.tryParse(per_fat.text.toString()),
                        per_protein:
                            double.tryParse(per_protein.text.toString()),
                        potassium_mg:
                            double.tryParse(potassium_mg.text.toString()),
                        protein_g: double.tryParse(protein_g.text.toString()),
                        dishTypes: list,
                        ingredients: listIng,
                        image: '',
                        health_score:
                            double.tryParse(health_score.text.toString()),
                        vit_c_mg: double.tryParse(vit_c_mg.text.toString()),
                        vegetarian: false,
                      );
                      newFood.addFood();
                      sharedPreferences!.setStringList('dishType',[]);


                    },
                    // ignore: prefer_const_constructors
                    child: Text("Add",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14)),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget ingredientForm() {
    return Container(
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.all(10)),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.only(left: 20),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'ingredients',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        lenIng++;
                        ingredents.add(TextEditingController());
                      });
                    },
                    child: Icon(Icons.add),
                  )),
            ],
          ),
          for (int i = 0; i < lenIng; i++)
            TextFormField(
              controller: ingredents[i],
              decoration: InputDecoration(
                fillColor: Colors.grey[200],
                contentPadding: EdgeInsets.all(3),
                hintText: "Ingredients" + i.toString(),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60),
                  borderSide: const BorderSide(style: BorderStyle.none),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(80),
                  borderSide: const BorderSide(style: BorderStyle.none),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget showDishType() {
    return Container(
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.all(10)),
          Container(
              padding: const EdgeInsets.only(left: 20),
              alignment: Alignment.topLeft,
              child: const Text(
                "Dish Type :",
                style: TextStyle(color: Colors.black, fontSize: 14),
              )),
          for (int i = 0; i < 5; i++) PickarViwe(listDishType[i].name),
        ],
      ),
    );
  }

  Widget allTextFormInfoFood() {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.all(10)),
        containerInfoFood('Title', keySignIn1, 'Name food', title),
        const Padding(padding: EdgeInsets.all(5)),
        containerInfoFood('Alcohol (g)', keySignIn2, 'Alcohol', alcohol_g),
        const Padding(padding: EdgeInsets.all(5)),
        containerInfoFood(
            'Carbohydrates (g)', keySignIn3, 'Carbohydrates ', carbohydrates_g),
        const Padding(padding: EdgeInsets.all(5)),
        containerInfoFood('Calcium (mg)', keySignIn4, 'Calcium', calcium_mg),
        const Padding(padding: EdgeInsets.all(5)),
        containerInfoFood('Calories', keySignIn5, 'calories', calories),
        const Padding(padding: EdgeInsets.all(5)),
        containerInfoFood(
            'Cholesterol (mg)', keySignIn6, 'Cholesterol', cholesterol_mg),
        const Padding(padding: EdgeInsets.all(5)),
        containerInfoFood(
            'Health Score', keySignIn7, 'Health Score', health_score),
        const Padding(padding: EdgeInsets.all(5)),
        containerInfoFood('Fiber (g)', keySignIn8, 'Fiber', fiber_g),
        const Padding(padding: EdgeInsets.all(5)),
        containerInfoFood('Per Carbs', keySignIn9, 'Per Carbs', per_carbs),
        const Padding(padding: EdgeInsets.all(5)),
        containerInfoFood('Per Fat', keySignIn10, 'Per Fat', per_fat),
        const Padding(padding: EdgeInsets.all(5)),
        containerInfoFood(
            'Per Protein', keySignIn11, 'Per Protein', per_protein),
        const Padding(padding: EdgeInsets.all(5)),
        containerInfoFood(
            'Potassium (mg)', keySignIn12, 'Potassium', potassium_mg),
        const Padding(padding: EdgeInsets.all(5)),
        containerInfoFood('Protein (g)', keySignIn13, 'Protein', protein_g),
        const Padding(padding: EdgeInsets.all(5)),
        containerInfoFood('Vit C (mg)', keySignIn14, 'Vit C', vit_c_mg),
      ],
    );
  }

  Widget containerInfoFood(title1, keyForm, hint, controlForm) {
    return Container(
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.only(left: 20),
              alignment: Alignment.topLeft,
              child: Text(
                title1.toString() + " :",
                style: const TextStyle(color: Colors.black, fontSize: 14),
              )),
          AppTextForms.registerTextForm(keyForm, context, hint, 0.8, 0.1,
              controlForm, FormTextType.Noun, TextInputType.name, () {}, ''),
        ],
      ),
    );
  }
}
