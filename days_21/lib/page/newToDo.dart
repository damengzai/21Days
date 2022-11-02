import 'package:days_21/bean/toDo.dart';
import 'package:days_21/control/ToDoListControl.dart';
import 'package:days_21/utils/sqlUtil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../control/AddToDoControl.dart';

class NewToDo extends StatelessWidget {
  NewToDo({super.key});

  final addToDoControl = Get.put(AddToDoControl());

  TextEditingController nameController = TextEditingController();

  addTodo() async {
    ToDo todo =
        ToDo(name: "第一个", timeStamp: DateTime.now().millisecondsSinceEpoch);
//    await Utils().addToDo(todo);
//    ToDo t = await Utils().getToDo();
//    print(t.toString());
//    await Utils().addToDoList(todo);
    ToDoListControl toDoListControl = Get.find();
    toDoListControl.addToDo(todo);
    await insertTodo(todo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('newTodo'.tr),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              // 名字
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'todoName'.tr),
              ),
              // 开始日期
              GestureDetector(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime(
                      addToDoControl.startDate.value.year,
                      addToDoControl.startDate.value.month,
                      addToDoControl.startDate.value.day,
                    ),
                    firstDate: DateTime(2022),
                    lastDate: DateTime(2023),
                  ).then((value) {
                    addToDoControl.setStartDate(value ?? DateTime.now());
                  });
                },
                child: Row(
                  children: [
                    Text('startDate'.tr),
                    Obx(
                      () => Text(
                        addToDoControl.startDate.string.substring(0, 10),
                      ),
                    ),
                  ],
                ),
              ),
              // 添加按钮
              TextButton(
                onPressed: () {
                  addTodo();
                },
                child: Text('add'.tr),
              )
            ],
          ),
        ),
      ),
    );
  }
}
