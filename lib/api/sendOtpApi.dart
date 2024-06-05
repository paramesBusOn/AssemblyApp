// ignore_for_file: file_names, prefer_interpolation_to_compose_strings, avoid_print, unused_local_variable
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:assempleyapp/api/fileUploadApi.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;

class GetJWTTokenS {
  static Future<Responce> callApi() async {
    Responce res = new Responce();
    String? deviceid = await getdeviceId();

    try {
      final response = await http.post(
          Uri.parse(
              'https://app.innerwheel.co.in/api/Authenticate/AuthorizationwithMobileNo'),
          headers: {
            "content-type": "application/json",
          },
          body: jsonEncode({
            "deviceCode": "$deviceid",
            "mobileNo": "9944900000",
            "fcmCode": ""
          }));
      log("req json: " +
          jsonEncode({
            "deviceCode": "$deviceid",
            "mobileNo": "9944900000",
            "fcmCode": ""
          }));
      log("Body message: " + response.body);
      log("Body message: " + response.statusCode.toString());

      if (response.statusCode == 200) {
        // Map data = json.decode(response.body);
        res.resCode = response.statusCode;
        res.responceBody = response.body;
        return res;
      } else if (response.statusCode >= 400 && response.statusCode <= 410) {
        res.resCode = response.statusCode;
        res.responceBody = response.body;
        return res;
      } else {
        res.resCode = response.statusCode;
        res.responceBody = "Exceptions";
        print("Error: ${response.body}");
        // throw Exception("Error");
        return res;
      }
    } catch (e) {
      res.resCode = 500;
      res.responceBody = "Exception: " + e.toString();
      print("Exception: " + e.toString());
      //  throw Exception(e.toString());
      return res;
    }
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
}
