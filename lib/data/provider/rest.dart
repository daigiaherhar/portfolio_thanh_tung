import 'dart:convert';

import 'package:portfolio_thanh_tung/constants/const_string.dart';
import 'package:http/http.dart' as http;

const baseUrl = CommonString.BASEURL;

abstract class RestAPIClient {
  var client = http.Client();

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
        throw response.statusCode ;
      }
    } catch (exception) {
      rethrow ;
    }
  }
}
