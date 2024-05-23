import 'dart:io';

import 'package:assempleyapp/Configurations/Screen.dart';
import 'package:assempleyapp/DBHelper/DBOperation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xcel;
import '../DBHelper/DbHelper.dart';
import '../DBModel/AssemblyDB.dart';
import 'package:permission_handler/permission_handler.dart';

class AssemblyController extends ChangeNotifier {
  init() {}

  insertData(
      List<AssemblyModel> values, BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    await DBOperation.insertEnqType(values, db);
    await DBOperation.getEnqData(db);
    Get.back();
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: Screens.width(context) * 0.8,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Material(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Text("Scanned Thank You..",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge!.copyWith(
                            color: Colors.green,
                          )),
                      // const SizedBox(height: 15),
                      // const Text(
                      //   "Message Text",
                      //   textAlign: TextAlign.center,
                      // ),
                      const SizedBox(height: 20),
                      //Buttons
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.05,
                        width: Screens.width(context) * 0.3,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5),
                            minimumSize: const Size(0, 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text(
                            'Close',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String currentDate() {
    DateTime now = DateTime.now();

    String currentDateTime =
        "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}T${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
    return currentDateTime;
  }

  static String? path = '';

   Future<void> createExcel(BuildContext context,ThemeData theme) async {
        final Database db = (await DBHelper.getInstance())!;

    List<AssemblyModel> values=await DBOperation.getEnqData(db);
    final xcel.Workbook workbook = xcel.Workbook();
    final xcel.Worksheet sheet = workbook.worksheets[0];
    // final xcel.Worksheet sheet2 = workbook.worksheets[1];

    // sheet.getRangeByName('A1').setText('Hello World!');
    sheet.getRangeByIndex(1, 1).setText("Event");
    sheet.getRangeByIndex(1, 2).setText("Type");
    sheet.getRangeByIndex(1, 3).setText("QRCode");
    sheet.getRangeByIndex(1, 4).setText("ScanTime");

    for (var i = 0; i < values.length; i++) {
      final item = values[i];
      sheet.getRangeByIndex(i + 2, 1).setText(item.event.toString());
      sheet.getRangeByIndex(i + 2, 2).setText(item.type.toString());
      sheet.getRangeByIndex(i + 2, 3).setText(item.qrCode.toString());
      sheet.getRangeByIndex(i + 2, 4).setText(item.scanTime.toString());
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    path = await getExternalDocumentPath();
    var id = DateTime.now().millisecondsSinceEpoch;

    // final String path = (await getApplicationSupportDirectory()).path;
    final String fileName =
        Platform.isIOS ? '$path\\Output.xlsx' : '$path/$id-test1.xlsx';
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: Screens.width(context) * 0.8,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Material(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Text("Sucessfull Saved..",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge!.copyWith(
                            color: Colors.green,
                          )),
                      // const SizedBox(height: 15),
                       Text(
                        "Path Name:$path",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      //Buttons
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.05,
                        width: Screens.width(context) * 0.3,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5),
                            minimumSize: const Size(0, 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text(
                            'Close',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Future<String> getExternalDocumentPath() async {
    // To check whether permission is given for this app or not.
    var status = await Permission.storage.status;
    print('Status::' + status.toString());
    if (!status.isGranted) {
      // If not we will ask for permission first
      await Permission.storage.request();
      await Permission.manageExternalStorage.request();
    }
    Directory _directory = Directory("");
    if (Platform.isAndroid) {
      // Redirects it to download folder in android
      _directory = (await getExternalStorageDirectory())!;
    } else {
      _directory = await getApplicationDocumentsDirectory();
    }

    final exPath = _directory.path;
    print("Saved Path2: $exPath");
    await Directory(exPath).create(recursive: true);
    print("Saved Path3: $exPath");

    return exPath;
  }
}
