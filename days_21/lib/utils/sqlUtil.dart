import 'package:days_21/bean/toDo.dart';
import 'package:sqflite/sqflite.dart';

const String DB_NAME = '/todo.db';
const String TABLE_NAME = 'todoList';
const int VERSION = 1;

//创建数据库
Future<Database> getDatabase() async {
  String dbPath = await getDatabasesPath();
  String path = dbPath + DB_NAME;
  print('-----dbpath' + path);
  Database database = await openDatabase(
      path, version: VERSION, onCreate: (Database db, int version) async {
        print('-----create db');
    await db.execute('CREATE TABLE $TABLE_NAME(id INTEGER PRIMARY KEY, timeStamp INTEGER, name TEXT)');
  });
  return database;
}

//插入数据
insertTodo(ToDo todo) async {
  Database db = await getDatabase();
  // db.insert(TABLE_NAME, todo.toJson());
  db.rawInsert('INSERT INTO $TABLE_NAME(timeStamp, name) VALUES(?,?)', [todo.timeStamp, todo.name]);
  await db.close();
}
//查询所有数据
Future<List<Map>> getAllTodo() async {
  Database db = await getDatabase();
  List<Map> list = await db.rawQuery('SELECT * FROM $TABLE_NAME');
  print(list);
  await db.close();
  return list;
}

//获取总数
Future<int> getToDoNum() async {
  Database db = await getDatabase();
  int toDoNum = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $TABLE_NAME'))??0;
  await db.close();
  return toDoNum;
}

//获取一条数据
getOneToDo(int id) async {
  Database db = await getDatabase();
  await db.rawQuery('SELECT * FROM $TABLE_NAME WHERE id = ?', [id]);
  await db.close();
}

//修改数据
updateTodo(ToDo toDo) async {
  Database db = await getDatabase();
  await db.rawUpdate('UPDATE $TABLE_NAME SET name = ? WHERE id = ?', [toDo.name, toDo.id]);
  await db.close();
}

// 删除数据
deleteTodo(ToDo toDo) async {
  Database db = await getDatabase();
  await db.rawDelete('DELETE FROM $TABLE_NAME WHERE id = ?', [toDo.id]);
  await db.close();
}

