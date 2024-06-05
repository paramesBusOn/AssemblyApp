import 'dart:convert';

import 'package:http/http.dart' as http;

class AttendentceApi {
  static Future<EventAttenPostModel> registerApi(
      EventAttenPostModel req) async {
    // final response = await createPostWithHeaders(
    //   'https://jagran.redphoenixfoundation.in/api/WebHooks/EventAttendance',
    //   headers: <String, String>{
    //     'Content-Type': 'application/json;',
    //   },
    //   body: req.map((e) => e.toJson()).toList(),
    // );

    final response = await http.post(
      Uri.parse(
          'https://jagran.redphoenixfoundation.in/api/WebHooks/EventAttendance'),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "id": 0,
        "event": req.event,
        "deviceCode": req.deviceCode,
        "scanTime": req.scanTime
      }), // Convert body data to JSON string
    );
    // print(req.map((e) => e.toJson()));
    print('status code::' + response.statusCode.toString());

    if (response.statusCode >= 200 && response.statusCode <= 210) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return EventAttenPostModel.fromJson(
          jsonDecode(response.body), response.statusCode);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      return EventAttenPostModel.fromJson({}, response.statusCode);
    }
  }
}

class EventAttenPostModel {
  int id;
  String event;
  String deviceCode;
  String scanTime;
  int? stcode;
  EventAttenPostModel(
      {required this.id,
      required this.event,
      required this.deviceCode,
      required this.scanTime,
      this.stcode});
  factory EventAttenPostModel.fromJson(Map<String, dynamic> json, int? stcode) {
    print(json);
    print(stcode);

    if (stcode! >= 200 && stcode <= 210) {
      return EventAttenPostModel(
          id: json['id'],
          event: json['event'],
          deviceCode: json['deviceCode'],
          scanTime: json['scanTime'],
          stcode: stcode);
    } else {
      return EventAttenPostModel(
          id: 0, event: '', deviceCode: '', scanTime: '', stcode: stcode);
    }
  }

  // Map<String, dynamic> toJson() => {
  //       'id': id,
  //       'event': event,
  //       // 'memberName': memberName,
  //       // 'signatureUrl': signatureUrl,
  //       'scanTime': scanTime,
  //       'deviceCode': deviceCode,
  //     };
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'id': id,
      'event': event,
      // 'memberName': memberName,
      // 'signatureUrl': signatureUrl,
      'scanTime': scanTime,
      'deviceCode': deviceCode,
    };
    return map;
  }
}
