import 'package:assempleyapp/DBModel/AssemblyDB.dart';
import 'package:sqflite/sqflite.dart';

class DBOperation {
  static Future insertEnqType(List<AssemblyModel> values, Database db) async {
    var data = values.map((e) => e.toMap()).toList();

    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableAssembly, es);
    });
    await batch.commit();
  }

  static Future<List<AssemblyModel>> getEnqData(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery('''
SELECT * FROM $tableAssembly;
''');
print("GETDB DATA::"+result.toString());
    return List.generate(result.length, (i) {
      return AssemblyModel(
        event: result[i]['EventName'].toString(),
        qrCode: result[i]['QrCode'].toString(),
        scanTime: result[i]['ScanTime'].toString(),
        type: result[i]['Type'].toString(),
      );
    });
  }
}
