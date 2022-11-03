import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../control/ToDoListControl.dart';
import '../view/toDoItemView.dart';


class AllToDoPage extends StatelessWidget{
  final toDoListControl = Get.put(ToDoListControl());
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(() => ListView.builder(
          itemCount: toDoListControl.toDoList.length,
          itemBuilder: (BuildContext context, int index) {
            return ToDoItemView(
              key: Key('i' + index.toString()),
              toDo: toDoListControl.toDoList[index],
            ); // Text(toDoListControl.toDoList[index].name);
          })),
    );
  }
}