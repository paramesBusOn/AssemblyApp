//
import 'package:assempleyapp/Configurations/Screen.dart';
import 'package:assempleyapp/api/RegisterApi.dart';
import 'package:assempleyapp/api/fileUploadApi.dart';
import 'package:assempleyapp/helpers/Utils.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as ui;
import 'dart:io';
import 'dart:typed_data';
import 'package:intl/intl.dart';

class RegisterController extends ChangeNotifier {
  final GlobalKey<SfSignaturePadState> signaturePadKey = GlobalKey();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final mycontroller = TextEditingController();
  final GlobalKey<FormFieldState> key = GlobalKey<FormFieldState>();

  init() {
    key.currentState!.reset();

    mycontroller.clear();
    path = '';
    clubname = '';
    handleClearButtonPressed();
    notifyListeners();
  }

  static Future<String?> getdeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'

      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
    return null;
  }

  bool? isEmpty = true;

  void handleClearButtonPressed() {
    signaturePadKey.currentState!.clear();
    notifyListeners();
  }

  // Future<int> registerApi(List<RegisterReqModel> req) async {
  //   final response = await createPostWithHeaders(
  //     'https://jagran.redphoenixfoundation.in/api/WebHooks/EventReg',
  //     headers: <String, String>{
  //       'Content-Type': 'application/json;',
  //     },
  //     body: req.map((e) => e.toJson()).toList(),
  //   );

  //   if (response.statusCode == 201) {
  //     // If the server did return a 201 CREATED response,
  //     // then parse the JSON.
  //     return response.statusCode;
  //   } else {
  //     // If the server did not return a 201 CREATED response,
  //     // then throw an exception.
  //     throw Exception('Failed to create album.');
  //   }
  // }

  // Future<http.Response> createPostWithHeaders(String url,
  //     {Map<String, String>? headers, body}) async {
  //   return await http.post(
  //     Uri.parse(url),
  //     headers: {
  //       "Content-Type": "application/json",
  //       ...headers!, // Merge additional headers if any
  //     },
  //     body: jsonEncode(body), // Convert body data to JSON string
  //   );
  // }

  var item = [
    "Avinashi East",
    "Calicut",
    "Calicut Central",
    "Calicut East",
    "Calicut Midtown",
    "Cannanore",
    "Chalakudy",
    "Cochin",
    "Cochin Global",
    "Cochin Midtown",
    "Cochin Muziris City",
    "Cochin Phoenix",
    "Cochin Vypin Island",
    "Cochin West",
    "Coimbatore",
    "Coimbatore Centenary",
    "Coimbatore East",
    "Coimbatore North",
    "Coimbatore South",
    "Coimbatore Synergy",
    "Coimbatore Tejas",
    "Coimbatore Vriksham",
    "Coimbatore West",
    "Dharapuram",
    "Erode",
    "Erode Cosmos",
    "Erode Cosmos Vibrant",
    "Erode North",
    "Erode Thindal",
    "Greater Cochin",
    "Kalamassery",
    "Ketti Valley",
    "Kodungallur",
    "Kolenchery",
    "Kotagiri",
    "Kunnamkulam",
    "Mettupalayam",
    "Muvattupuzha",
    "Nileshwar",
    "Ootacamund",
    "Ottapalam",
    "Palghat",
    "Palghat East",
    "Parur",
    "Pollachi",
    "Royal Heritage",
    "Tellicherry",
    "Tirupur",
    "Tirupur South",
    "Trichur",
    "Udumalpet"
  ];

  static String? path = '';
  String? clubname = '';
  bool progreess = false;
  Future handleSaveButtonPressed(BuildContext context, ThemeData theme) async {
    progreess = true;
    List<Path> paths = signaturePadKey.currentState!.toPathList();
    if (paths.isEmpty) {
      isEmpty = true;
    } else {
      isEmpty = false;
    }

    if (formKey.currentState!.validate()) {
      if (isEmpty == false) {
        final data =
            await signaturePadKey.currentState!.toImage(pixelRatio: 3.0);
        final bytes = await data.toByteData(format: ui.ImageByteFormat.png);

        // List<Path> paths = signaturePadKey.currentState!.toPathList();
        path = await getExternalDocumentPath();

        var id = DateTime.now().millisecondsSinceEpoch;

        // final String path = (await getApplicationSupportDirectory()).path;
        final String fileName = Platform.isIOS
            ? '$path\/Signature_$id.png'
            : '$path/Signature_$id.png';
        final File file = File(fileName);
        final buffer = bytes!.buffer;

        await file.writeAsBytes(
            buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes),
            flush: true);
        print(path);

        String result = '';
        await FileUpLoadApi.filesend(file, Utils.token!, 'UploadProfilePic')
            .then((valueres) {
          if (valueres.resCode! >= 200 && valueres.resCode! <= 210) {
            result = valueres.responceBody!;
          } else {
            // apicalledPic = false;
            notifyListeners();
            Get.defaultDialog(
                    title: 'Try again...!!!',
                    middleText: '${valueres.responceBody}')
                .then((value) {});
          }
        });
        // await writeToFile(bytes, path!);
        print('Signature Img url$result');
        //
        String? deviceid = await getdeviceId();
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('yyyy-MM-ddThh:mm:ssZ').format(now);
        RegisterPostModel req = RegisterPostModel(
            id: 0,
            clubName: clubname,
            memberName: mycontroller.text,
            signatureUrl: result,
            regTime: formattedDate.toString(),
            deviceCode: '$deviceid');
        //
        RegisterApi.registerApi(req).then((value) {
          if (value.stcode! >= 200 && value.stcode! <= 210) {
            progreess = false;
            // init();
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
                              Text("Register Sucessfull..",
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    color: Colors.green,
                                  )),
                              // const SizedBox(height: 15),
                              // Text(
                              //   "Path Name:$path",
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
                                    progreess = false;
                                    Navigator.pop(context);

                                    notifyListeners();
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
            notifyListeners();
          } else {
            progreess = false;
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
                              Text("Something went wrong Try again..!!",
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    color: Colors.red,
                                  )),
                              // const SizedBox(height: 15),
                              // Text(
                              //   "Path Name:$path",
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
                                    progreess = false;
                                    Navigator.pop(context);
                                    notifyListeners();
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
        });
        notifyListeners();
      }
    }
    progreess = false;
    init();
    notifyListeners();
  }

  Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  static Future<String> getExternalDocumentPath() async {
    // To check whether permission is given for this app or not.
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      // If not we will ask for permission first
      await Permission.storage.request();
      await Permission.manageExternalStorage.request();
    }
    Directory directory = Directory("");
    if (Platform.isAndroid) {
      // Redirects it to download folder in android
      directory = (await getExternalStorageDirectory())!;
    } else {
      directory = await getApplicationDocumentsDirectory();
    }

    final exPath = directory.path;
    await Directory(exPath).create(recursive: true);

    return exPath;
  }
}

class RegisterReqModel {
  int? id;
  String? clubName;
  String? memberName;
  String? signatureUrl;
  String? regTime; // "2024-06-04T18:20:23.176Z",
  String? deviceCode;

  RegisterReqModel({
    required this.id,
    required this.clubName,
    required this.memberName,
    required this.signatureUrl,
    required this.regTime,
    required this.deviceCode,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'clubName': clubName,
        'memberName': memberName,
        'signatureUrl': signatureUrl,
        'regTime': regTime,
        'deviceCode': deviceCode,
      };
}
