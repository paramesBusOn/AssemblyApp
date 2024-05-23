import 'dart:developer';

import 'package:assempleyapp/Controller/assemblyController.dart';
import 'package:assempleyapp/DBModel/AssemblyDB.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

class QrScanner extends StatefulWidget {
  QrScanner({Key? key, required this.event, required this.type})
      : super(key: key);
  String event;
  String type;
  @override
  State<QrScanner> createState() => QrScannerState();
}

class QrScannerState extends State<QrScanner> {
  static bool orderscan = false;
  static bool leadscan = false;
  static bool quotescan = false;
  static bool stockscan = false;
  static bool pricelistscan = false;

  MobileScannerController cameraController =
      MobileScannerController(detectionSpeed: DetectionSpeed.noDuplicates);
  // OrderNewController? orderNewController;
  List<Barcode> barcodes = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      barcodes.clear();
    });
    log("barcodes:::" + barcodes.toString());
  }

  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.back();
      return Future.value(true);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: onbackpress,
      child: Scaffold(
        appBar: AppBar(title: Text("Mobile Scanner")),
        body: MobileScanner(
          controller: cameraController,
          onDetect: (capture) {
            barcodes = capture.barcodes;

            for (var barcode in barcodes) {
              if (barcodes.isNotEmpty) {
                List<AssemblyModel> temp = [];
                temp.add(AssemblyModel(
                    event: widget.event,
                    qrCode: barcode.rawValue.toString(),
                    scanTime: context.read<AssemblyController>().currentDate(),
                    type: widget.type));
                context
                    .read<AssemblyController>()
                    .insertData(temp, context, theme);
              }
              // context.read<OrderNewController>().scanneddataget(barcode.rawValue ??'',context);
            }
          },
        ),
      ),
    );
  }
}
