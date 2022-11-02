import 'package:days_21/bean/toDo.dart';
import 'package:days_21/control/ToDoListControl.dart';
import 'package:days_21/utils/sqlUtil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewToDo extends StatelessWidget {
  const NewToDo({super.key});

  addTodo() async {
    ToDo todo = ToDo(name: "第一个", timeStamp: DateTime.now().millisecond);
//    await Utils().addToDo(todo);
//    ToDo t = await Utils().getToDo();
//    print(t.toString());
//    await Utils().addToDoList(todo);
      ToDoListControl toDoListControl = Get.find();
      toDoListControl.addToDo(todo);
      await insertTodo(todo);
      await getAllTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("21Days"),
      ),
      body: SafeArea(child: Center(child: Column(children: [
        TextField(decoration: InputDecoration(labelText: 'name'),),
      ],),),),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addTodo(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
