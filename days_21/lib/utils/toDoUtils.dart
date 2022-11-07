import 'sqlUtil.dart';
import '../bean/toDo.dart';

//获取所有todos
Future<List<ToDo>> getAllTodos() async {
  List<Map> allTodoMap = await getAllTodoFromSql();
  List<ToDo> toDoList = allTodoMap.map((e) => ToDo.fromJson(e)).toList();
  return toDoList;
}

//插入一条todo
Future<int> insertTodo(ToDo toDo) async {
  int result = await insertTodoToSql(toDo);
  return result;
}

//删除一条todo
Future<int> deleteTodo(int id) async {
  int result = await deleteToDoFromSqlById(id);
  return result;
}

//更改数据
Future<int> updateTodo(ToDo todo) async {
  int result = await updateTodoToSql(todo);
  return result;
}