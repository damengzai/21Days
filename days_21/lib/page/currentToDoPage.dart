import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../control/toDoListControl.dart';
import '../view/toDoItemView.dart';

class CurrentToDoPage extends StatelessWidget{
  final toDoListControl = Get.put(ToDoListControl());
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Obx(() => ListView.builder(
          itemCount: toDoListControl.doingToDoList.length,
          itemBuilder: (BuildContext context, int index) {
            return ToDoItemView(
              key: Key('i' + index.toString()),
              toDo: toDoListControl.doingToDoList[index],
            ); // Text(toDoListControl.toDoList[index].name);
          })),
    );
  }
}