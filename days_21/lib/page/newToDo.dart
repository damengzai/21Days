import 'package:days_21/bean/toDo.dart';
import 'package:days_21/control/ToDoListControl.dart';
import 'package:days_21/utils/sharedPreference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewToDo extends StatelessWidget {
  const NewToDo({super.key});

  addTodo() async {
    ToDo todo = ToDo(name: "第一个", timeStmp: DateTime.now().millisecond);
//    await Utils().addToDo(todo);
//    ToDo t = await Utils().getToDo();
//    print(t.toString());
//    await Utils().addToDoList(todo);
      ToDoListControl toDoListControl = Get.find();
      toDoListControl.addToDo(todo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("21Days"),
      ),
      body: const Text('third'),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addTodo(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
