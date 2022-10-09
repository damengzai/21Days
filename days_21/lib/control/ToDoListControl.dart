import 'package:days_21/bean/toDo.dart';
import 'package:get/get.dart';

class ToDoListControl extends GetxController{
  final toDoList = [ToDo(name: "old")].obs;

  addToDo() {
    toDoList.add(ToDo(name: "new"));
  }
}