import 'package:days_21/bean/toDo.dart';

import 'sqlUtil.dart';

//获取所有todos
Future<List<ToDo>> getAllTodos() async {
  List<Map> allTodoMap = await getAllTodoFromSql();
  List<ToDo> toDoList = allTodoMap.map((e) => ToDo.fromJson(e)).toList();
  print(toDoList);
  return toDoList;
}

//插入一条todo
insertTodo(ToDo toDo) {
  print(toDo);
}