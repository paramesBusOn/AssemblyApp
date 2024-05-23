const String tableAssembly = "AssemblyTable";

class AssemblyTableColumns {
  static const String qrCode = "QrCode";
  static const String event = "EventName";
  static const String scanTime = "ScanTime";
  static const String type = "Type";
}

class AssemblyModel {
  // int id;
  String qrCode;
  String event;
  String scanTime;
  String type;
  AssemblyModel(
      {
      //required this.id,
      required this.event,
      required this.qrCode,
      required this.scanTime,
      required this.type});

  Map<String, Object?> toMap() => {
        // AssemblyTableColumns.id: id,
        AssemblyTableColumns.qrCode: qrCode,
        AssemblyTableColumns.event: event,
        AssemblyTableColumns.scanTime: scanTime,
        AssemblyTableColumns.type: type,
      };
}
