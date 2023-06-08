import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:ketkray_garden/services/status_code.dart';
import 'package:supercharged/supercharged.dart';

class CallApiServiceCenter {
  CallApiServiceCenter._();

  static fetchAllProduct(
    Function(dynamic value) callback,
  ) async {
    EasyLoading.show();

    final response = await http.get(
      Uri.parse('http://192.168.1.111:5000/'),
    );

    if (response.statusCode == StatusCode.ok) {
      // debugPrint('fetchDailyCard -> $responseJson');

      callback(response.body.parseJSON());

      // debugPrint(response.body.parseJSON().toString());
      // setState(() {});
    } else {}

    EasyLoading.dismiss();
  }
}
