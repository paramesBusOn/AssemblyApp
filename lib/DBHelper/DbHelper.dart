import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../DBModel/AssemblyDB.dart';

class DBHelper {
  static Database? _db;

  DBHelper._() {}
  static Future<Database?> getInstance() async {
    String path = await getDatabasesPath();
    if (_db == null) {
      _db = await openDatabase(join(path, 'Assembly.db'),
          version: 1, onCreate: createTable);
    }
    return _db;
  }

  static void createTable(Database database, int version) async {
    await database.execute('''
           create table $tableAssembly(
             Id integer primary key autoincrement,
             ${AssemblyTableColumns.qrCode} varchar,
             ${AssemblyTableColumns.event} varchar ,
             ${AssemblyTableColumns.scanTime} varchar ,
             ${AssemblyTableColumns.type} varchar           
             )
        ''');
  }

  
}
