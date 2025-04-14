import 'dart:convert';

// import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:portfolio_thanh_tung/constants/const_string.dart';
import 'package:http/http.dart' as http;
import 'download/download_mobile.dart'
    if (dart.library.html) 'download/download_web.dart';

const baseUrl = CommonString.BASEURL;

abstract class ServiceData {
  var client = http.Client();
  final Dio dio = Dio();

  read(String file) async {
    try {
      var response = await client.read(
        Uri.https(CommonString.BASEURL, 'portfolio_data/$file'),
      );
      return response;
    } catch (exception) {
      rethrow;
    }
  }

  get(String file) async {
    try {
      var response = await client.get(
        Uri.https(CommonString.BASEURL, 'portfolio_data/$file'),
      );
      print("response.statusCode");
      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw response.statusCode;
      }
    } catch (exception) {
      rethrow;
    }
  }

  downFile() async {
    try {
      String url =
          "https://daigiaherhar.github.io/portfolio_data/CV_Mobile_Doan_Thanh_Tung.pdf";
      return downFileDefault(dio, url: url);
      if (kIsWeb) {
        return downFileDefault(dio, url: url);
      } else {
        String name = url.split("/").last;
        final response =
            dio.download(url, (await getTemporaryDirectory()).path + name);
        // print()
        return response;
      }
    } catch (exception) {
      rethrow;
    }
  }
}
