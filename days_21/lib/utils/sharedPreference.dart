import 'dart:convert';

import 'package:days_21/bean/toDo.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String TODO = 'todo';
const String TODOLIST = 'todo_list';

class Utils {
  // 添加一个TODO
  Future<void> addToDo(ToDo toDo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String toDoString = toDo.toString();
    String todoJsonString = jsonEncode(toDo);
    prefs.setString(TODO, todoJsonString);
  }

  // 读取一个TODO
  Future<ToDo> getToDo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String todoString = prefs.getString(TODO) ?? 'err';
    Map todoJson = jsonDecode(todoString);
    ToDo todoObj = ToDo.fromJson(todoJson);
    return todoObj;
  }

  // 添加TODO List
  Future<void> addToDoList(ToDo toDo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<ToDo> toDoList = await getToDoList();
    toDoList.add(toDo);
//    List<String> todoStringList = toDoList.map((e) => jsonEncode(e)).toList();
    String todoListString = jsonEncode(toDoList);
    prefs.setString(TODOLIST, todoListString);
  }

  // 获取TODO List
  Future<List<ToDo>> getToDoList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String todoListString = prefs.getString(TODOLIST) ?? '[{"name":"name", "timeStamp": 0}]';
    List<dynamic> toDoMapList = jsonDecode(todoListString);
    List<ToDo> toDoList = toDoMapList.map((e) => ToDo.fromJson(e)).toList();
    return toDoList;
  }
}