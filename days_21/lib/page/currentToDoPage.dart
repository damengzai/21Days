import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../control/toDoListControl.dart';
import '../constant/constants.dart';
import '../view/toDoItemView.dart';
import '../bean/toDo.dart';
import '../utils/toDoUtils.dart';

class CurrentToDoPage extends StatelessWidget {
  final toDoListControl = Get.put(ToDoListControl());

  giveUpToDo(ToDo toDo) async {
    toDo.status = toDoStatus.giveUp.index;
    updateTodo(toDo).then((value) {
      if (value > 0) {
        // 放弃成功
        toDoListControl.removeDoingTodo(toDo);
        Get.showSnackbar(GetSnackBar(
          messageText: Text(
            'giveUpNotice'.tr,
            style: snakeBarTextStyle,
          ),
          duration: const Duration(seconds: 2),
        ));
      } else {
        // 失败
      }
    });
  }

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
                    onPressed: (BuildContext context) {
                      giveUpToDo(toDoListControl.doingToDoList[index]);
                    },
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
