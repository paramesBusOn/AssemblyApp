import 'dart:convert';

import 'package:http/http.dart' as http;

class RegisterApi {
  static Future<RegisterPostModel> registerApi(RegisterPostModel req) async {
    // final response = await createPostWithHeaders(
    //   'https://jagran.redphoenixfoundation.in/api/WebHooks/EventAttendance',
    //   headers: <String, String>{
    //     'Content-Type': 'application/json;',
    //   },
    //   body: req.map((e) => e.toJson()).toList(),
    // );

    final response = await http.post(
      Uri.parse('https://jagran.redphoenixfoundation.in/api/WebHooks/EventReg'),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "id": 0,
        "clubName": req.clubName,
        "memberName": req.memberName,
        "signatureUrl": req.signatureUrl,
        "regTime": req.regTime,
        "deviceCode": req.deviceCode
      }), // Convert body data to JSON string
    );
    print(response.statusCode);
    print(jsonEncode({
        "id": 0,
        "clubName": req.clubName,
        "memberName": req.memberName,
        "signatureUrl": req.signatureUrl,
        "regTime": req.regTime,
        "deviceCode": req.deviceCode
      }));

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return RegisterPostModel.fromJson(
          jsonDecode(response.body), response.statusCode);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      return RegisterPostModel.fromJson({}, response.statusCode);
    }
  }
}

class RegisterPostModel {
  int? id;
  String? clubName;
  String? memberName;
  String? signatureUrl;
  String? regTime; // "2024-06-04T18:20:23.176Z",
  String? deviceCode;
  int? stcode;
  RegisterPostModel(
      {required this.id,
      required this.clubName,
      required this.memberName,
      required this.signatureUrl,
      required this.regTime,
      required this.deviceCode,
      this.stcode});
  factory RegisterPostModel.fromJson(Map<String, dynamic> json, int? stcode) {
    print(json);
    if (stcode! >= 200 && stcode <= 210) {
      return RegisterPostModel(
          id: json['id'],
          deviceCode: json['deviceCode'],
          stcode: stcode,
          clubName: json['clubName'],
          memberName: json['memberName'],
          signatureUrl: json['signatureUrl'],
          regTime: json['regTime']);
    } else {
      return RegisterPostModel(
          id: 0,
          deviceCode: '',
          stcode: stcode,
          clubName: '',
          memberName: '',
          signatureUrl: '',
          regTime: '');
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'clubName': clubName,
        'memberName': memberName,
        'signatureUrl': signatureUrl,
        'regTime': regTime,
        'deviceCode': deviceCode,
      };
}
