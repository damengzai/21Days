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
getAllTodo() async {
  Database db = await getDatabase();
  List<Map> list = await db.rawQuery('SELECT * FROM $TABLE_NAME');
  print(list);
  await db.close();
}
