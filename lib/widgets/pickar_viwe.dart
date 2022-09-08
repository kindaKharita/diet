import 'package:diet/utils/color.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class PickarViwe extends StatefulWidget {
  String List;
  bool isAdd=false;
  PickarViwe(this.List);
  @override
  _PickarViweState createState() => _PickarViweState();
}

class _PickarViweState extends State<PickarViwe> {

  @override
  Widget build(BuildContext context) {

    return Container(
           child: ListTile(
              title: Text(
                widget.List,
              ),
              leading: IconButton(
                  icon: widget.isAdd
                      ? Icon(
                    Icons.select_all,
                    color: colorhex,
                  )
                      : Icon(Icons.crop_square),

                  // autofocus: Fo,
                  onPressed: () async {
                    // sharedPreferences!.setStringList('dishType',[]);
                    List<String> listType = sharedPreferences!.getStringList("dishType")!;
                    if(listType.contains(widget.List)){
                      listType.add(widget.List);
                      sharedPreferences!.setStringList('dishType',listType);
                    }else{
                      listType.remove(widget.List);
                      sharedPreferences!.setStringList('dishType',listType);
                    }
                    setState(() {
                      widget.isAdd=!widget.isAdd;
                    });
                  }
                // subtitle: Text(selectedGender.toString()),
              ),
            ),

      );
  }
}
