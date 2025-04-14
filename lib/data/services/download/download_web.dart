import 'package:flutter/foundation.dart';
import 'package:portfolio_thanh_tung/data/services/service_data.dart';

import 'dart:js_interop';

import 'package:dio/dio.dart';

import 'package:web/web.dart' as web;

Future downFileDefault(Dio dio, {required String url}) async {
  try {
    String name = url.split("/").last;
    if (kIsWeb) {
      final rs = await dio.get<List<int>>(
        url,
        options: Options(
            responseType:
            ResponseType.bytes), // Set the response type to `bytes`.
      );

      // // Tạo blob và tạo đường dẫn tạm
      final blob =
      web.Blob([Uint8List.fromList(rs.data!)] as JSArray<web.BlobPart>);
      final blobUrl = web.URL.createObjectURL(blob);

      final anchor = web.HTMLAnchorElement()
        ..href = blobUrl
        ..download = name
        ..click();

      web.document.body?.append(anchor);
      anchor.click();
      anchor.remove();
      web.URL.revokeObjectURL(blobUrl);
    }

    //
    // // uri.
    // // Directory dir = Platform.isAndroid
    // //     ? await getExternalStorageDirectory() ?? await getApplicationDocumentsDirectory()
    // //     : await getApplicationDocumentsDirectory();
    // // String name = url.split("/").last;
    // // final response = dio.download(
    // //     "https://daigiaherhar.github.io/portfolio_data/CV_Mobile_Doan_Thanh_Tung.pdf",
    // //     ("3424/") + name);
    //
    // // return response;
  } catch (exception) {
    rethrow;
  }
}

abstract class ServiceDataWeb extends ServiceData {
  downFileWeb() async {}
}
