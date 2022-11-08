import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/toDoUtils.dart';
import '../utils/sharedPreference.dart';
import '../bean/toDo.dart';

class ToDoListControl extends GetxController {
  final toDoList = [ToDo(name: "old")].obs;
  final doingToDoList = [].obs;

  addDoingToDo(ToDo toDo) {
    doingToDoList.add(toDo);
  }

  removeDoingTodo(ToDo toDo) {
    doingToDoList.removeWhere((item) => item.id == toDo.id);
  }

  removeToDo(int toDoId) {
    toDoList.removeWhere((element) => element.id == toDoId);
  }

  @override
  void onInit() {
    super.onInit();
    getAllTodos().then((todoList) async {
      //如果今天已经处理过，不需要再次处理
      if (DateUtils.dateOnly((DateTime.tryParse(await getAutoClickDate()) ??
                  DateTime.now()))
              .difference(DateUtils.dateOnly(DateTime.now()))
              .inDays >=
          1) {
        autoClickToDos(todoList);
        setAutoClickDate(DateTime.now().toString());
      }
      doingToDoList.value = todoList
          .where((todoItem) => todoItem.status == toDoStatus.doing.index)
          .toList();
      toDoList.value = todoList;
    });
  }
}
