import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'customers.db');
    Database myDb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return myDb;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) {
    print('__________Database and table are upgraded___________');
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
   CREATE TABLE "Users"(
    "id" INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT ,
    "name" TEXT ,
    "email" TEXT,
    "balance" REAL 
   )
   ''');
    print('__________Database and table are created___________');
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  detletetData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

    deleteDb() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'customers.db');
    
    return deleteDatabase(path);
  }
}
