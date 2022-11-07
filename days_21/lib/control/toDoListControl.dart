import 'package:days_21/bean/toDo.dart';
import 'package:days_21/utils/sharedPreference.dart';
import 'package:get/get.dart';
import '../utils/toDoUtils.dart';

class ToDoListControl extends GetxController {
  final toDoList = [ToDo(name: "old")].obs;

  addToDo(ToDo toDo) {
    toDoList.add(toDo);
    // Utils().addToDoList(toDo);
  }

  removeToDo(int toDoId) {
    toDoList.removeWhere((element) => element.id == toDoId);

  }

  @override
  void onInit() {
    super.onInit();
    getAllTodos().then((todoList) {
      toDoList.value = todoList;
    });
  }
}
