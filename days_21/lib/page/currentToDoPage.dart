import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../control/toDoListControl.dart';
import '../view/toDoItemView.dart';

class CurrentToDoPage extends StatelessWidget {
  final toDoListControl = Get.put(ToDoListControl());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(() => ListView.builder(
          itemCount: toDoListControl.doingToDoList.length,
          itemBuilder: (BuildContext context, int index) {
            return Slidable(
              key: Key('i_$index'),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                extentRatio: 0.3,
                children: [
                  SlidableAction(
                    onPressed: (BuildContext context) {},
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'giveUp'.tr,
                  )
                ],
              ),
              child: ToDoItemView(
                toDo: toDoListControl.doingToDoList[index],
              ),
            ); // Text(toDoListControl.toDoList[index].name);
          })),
    );
  }
}
