// ignore_for_file: unnecessary_string_interpolations, avoid_print, non_constant_identifier_names, prefer_interpolation_to_compose_strings, unnecessary_brace_in_string_interps, unnecessary_new

import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

class FileUpLoadApi {
  static Future<Responce> filesend(
      File filesdata, String token, String midaName) async {
    Responce respon = new Responce();
    try {
      var url = Uri.parse(
          "https://app.innerwheel.co.in/api/InnerWheel/$midaName?filename=${filesdata.path.split('/').last}");
      print("url: ${url}");
      var request = http.MultipartRequest('POST', url);
      var file = await http.MultipartFile.fromPath('file', '${filesdata.path}',
          filename: '${filesdata.path.split('/').last}');
      request.files.add(file);
      var headers = {'Authorization': 'bearer ${token}'};
      request.headers.addAll(headers);
      var response = await request.send();

      if (response.statusCode == 200) {
        // Request succeeded, parse the response body
        var responseBody = await response.stream.bytesToString();
        // Process the response data as needed
        respon.resCode = response.statusCode;
        respon.responceBody = responseBody;
        print("url: " + responseBody);
        return respon;
      } else {
        // Request failed
        print('Request failed with status: ${response.statusCode}');
        print('Responce: ${response.reasonPhrase}');
        respon.resCode = response.statusCode;
        respon.responceBody = response.reasonPhrase;
        return respon;
      }
    } catch (e) {
      log("except : ${e.toString()}");
      respon.resCode = 500;
      respon.responceBody = e.toString();
      return respon;
    }
  }
}

class Responce {
  String? responceBody;
  int? resCode;

  Responce({this.resCode, this.responceBody});

  factory Responce.getRes(int res, String body) {
    return Responce(resCode: res, responceBody: body);
  }
}
