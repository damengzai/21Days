import 'package:days_21/view/flipCard/flipCard.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../control/toDoListControl.dart';
import '../view/toDoItemView.dart';

class AllToDoPage extends StatelessWidget {
  ToDoListControl toDoListControl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(
        () => ListView.builder(
          itemCount: toDoListControl.toDoList.length,
          itemBuilder: (BuildContext context, int index) {
            return FlipCard(
              direction: FlipDirection.VERTICAL,
              front: ToDoItemView(
                key: Key('i' + index.toString()),
                toDo: toDoListControl.toDoList[index],
              ),
              back: Text('back', key: Key('back_i_$index')),
            ); // Text(toDoListControl.toDoList[index].name);
          },
        ),
      ),
    );
  }
}
