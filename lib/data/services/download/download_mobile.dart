import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:portfolio_thanh_tung/data/services/service_data.dart';

Future downFileDefault(Dio dio, {required String url}) async {
  try {
    String name = url.split("/").last;

    Directory dir = Platform.isAndroid
        ? Directory('/storage/emulated/0/Download/portfolio_thanh_tung')
        : await getApplicationDocumentsDirectory();
    final response = dio.download(url, '${dir.path}/$name');
    print("getTemporaryDirectory()");
    print(dir.path);
    return response;
  } catch (exception) {
    rethrow;
  }
}
