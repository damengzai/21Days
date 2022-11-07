import 'package:sqflite/sqflite.dart';
import '../bean/toDo.dart';

const String DB_NAME = '/todo.db';
const String TABLE_NAME = 'todoList';
const int VERSION = 1;

//创建数据库
Future<Database> getDatabase() async {
  String dbPath = await getDatabasesPath();
  String path = dbPath + DB_NAME;

  Database database = await openDatabase(
    path, version: VERSION,
    onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE $TABLE_NAME(id INTEGER PRIMARY KEY, timeStamp INTEGER, name TEXT, startDate TEXT, endDate TEXT, clickDate TEXT, status INTEGER, type INTEGER)');
    },
    //     onUpgrade: (Database db, int oldVersion, int newVersion) {
    //   try {
    //     var batch = db.batch();
    //     if (oldVersion == 4) {
    //       batch.execute("""ALTER TABLE $TABLE_NAME ADD COLUMN startDate TEXT""");
    //       batch.execute("""ALTER TABLE $TABLE_NAME ADD COLUMN endDate TEXT""");
    //       batch.execute("""ALTER TABLE $TABLE_NAME ADD COLUMN clickDate TEXT""");
    //       batch.execute("""ALTER TABLE $TABLE_NAME ADD COLUMN status INTEGER""");
    //       batch.execute("""ALTER TABLE $TABLE_NAME ADD COLUMN type INTEGER""");
    //     }
    //     batch.commit();
    //   } catch (e) {
    //     print(e);
    //   }
    // }
  );
  return database;
}

//插入数据
Future<int> insertTodoToSql(ToDo todo) async {
  Database db = await getDatabase();
  // db.insert(TABLE_NAME, todo.toJson());
  int result = await db.rawInsert(
      'INSERT INTO $TABLE_NAME(timeStamp, name, startDate, endDate, clickDate, status, type) VALUES(?,?,?,?,?,?,?)',
      [
        todo.timeStamp,
        todo.name,
        todo.startDate,
        todo.endDate,
        todo.clickDate,
        todo.status,
        todo.type
      ]);
  await db.close();
  return result;
}

//查询所有数据
Future<List<Map>> getAllTodoFromSql() async {
  Database db = await getDatabase();
  List<Map> list = await db.rawQuery('SELECT * FROM $TABLE_NAME');
  print(list);
  await db.close();
  return list;
}

//获取总数
Future<int> getToDoNumFromSql() async {
  Database db = await getDatabase();
  int toDoNum = Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM $TABLE_NAME')) ??
      0;
  await db.close();
  return toDoNum;
}

//获取一条数据
getOneToDoFromSql(int id) async {
  Database db = await getDatabase();
  await db.rawQuery('SELECT * FROM $TABLE_NAME WHERE id = ?', [id]);
  await db.close();
}

//修改数据
Future<int> updateTodoToSql(ToDo toDo) async {
  Database db = await getDatabase();
  int result = await db.rawUpdate(
      'UPDATE $TABLE_NAME SET name = ?, startDate = ?, endDate = ?, clickDate = ?,status = ?,type = ?  WHERE id = ?',
      [
        toDo.name,
        toDo.startDate,
        toDo.endDate,
        toDo.clickDate,
        toDo.status,
        toDo.type,
        toDo.id
      ]);
  await db.close();
  return result;
}

// // 修改状态
// updateTodoStatusToSql(int id, int status) async {
//   Database db = await getDatabase();
//   await db.rawUpdate(
//       'UPDATE $TABLE_NAME SET status = ? WHERE id = ?', [status, id]);
//   await db.close();
// }

// 删除数据
Future<int> deleteTodoFromSql(ToDo toDo) async {
  Database db = await getDatabase();
  int result =
      await db.rawDelete('DELETE FROM $TABLE_NAME WHERE id = ?', [toDo.id]);
  await db.close();
  return result;
}

// 删除数据
Future<int> deleteToDoFromSqlById(int id) async {
  Database db = await getDatabase();
  int result = await db.rawDelete('DELETE FROM $TABLE_NAME WHERE id = ?', [id]);
  await db.close();
  return result;
}
