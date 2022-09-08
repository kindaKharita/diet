import 'package:flutter/material.dart';

import '../main.dart';

class RefreshWidget extends StatelessWidget {
  List<String> selectedDisease;
  var name ;
  RefreshWidget({required this.selectedDisease,this.name});
  @override
  Widget build(BuildContext context) {
    return  IconButton(
      icon:selectedDisease.contains(name)?
      Icon(Icons.select_all)
          :Icon(Icons.crop_square),

      onPressed: ()  async {
        // ignore: avoid_print
        print(selectedDisease);
        // ignore: avoid_print
        print(name);
        if(!selectedDisease.contains(name))
        {
          selectedDisease.add(name);

        }else{
          selectedDisease.remove(name);

        }
        await sharedPreferences!.remove(
            'disease');
        await sharedPreferences!.setStringList(
            'disease', selectedDisease);

        // isActive?print(''):Navigator.pushReplacement(    context,  MaterialPageRoute(
        //     builder: (context) => this.build(context)));
        Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (context) => RefreshWidget(selectedDisease: selectedDisease)));
      },
    );
  }
}
