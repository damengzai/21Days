import 'dart:math';

import 'package:days_21/view/flipCard/flipCard.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../control/toDoListControl.dart';
import '../view/toDoItemView.dart';
import '../constant/constants.dart';

class AllToDoPage extends StatelessWidget {
  ToDoListControl toDoListControl = Get.find();
  
  String getSY() {
    int length = sy.length;
    int i = Random().nextInt(length);
    return sy[i];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(
        () => ListView.builder(
          itemExtent: 114,
          itemCount: toDoListControl.toDoList.length,
          itemBuilder: (BuildContext context, int index) {
            return FlipCard(
              direction: FlipDirection.VERTICAL,
              front: ToDoItemView(
                key: Key('i' + index.toString()),
                toDo: toDoListControl.toDoList[index],
              ),
              back: Padding(
                padding: const EdgeInsets.only(left: 4, right: 4),
                child: Text(getSY(), key: Key('back_i_$index')),
              ),
            ); // Text(toDoListControl.toDoList[index].name);
          },
        ),
      ),
    );
  }
}
