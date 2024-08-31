// ignore_for_file: deprecated_member_use, avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;
import '../core_helper/app_global.dart';
import '../core_helper/preference.dart';
import 'api.dart';


class HttpService {

  // =========================================================== Main Request Function
  Future<dynamic> request(BuildContext context, {
    required String endPoint,
    required RequestType requestType,
    required Map<String, String> header,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
  }) async {
    http.Response? response;
    Duration timeoutDuration = const Duration(seconds: 20);
    AppGlobal.languageCode = Preference.getString(PrefKeys.languageCode) ?? ui.window.locale.languageCode;

    // languageCode = "/$languageCode/";
    Uri uri = Uri.parse(EndPoints.serverUrl + endPoint).replace(
        queryParameters: queryParams);
    try {
      switch (requestType) {
        case RequestType.Post:
          {
            response = await http
                .post(
              uri,
              headers: header,
              encoding: Encoding.getByName("utf-8"),
              body: json.encode(body),
            )
                .timeout(timeoutDuration);
          }
          break;
        case RequestType.Put:
          {
            response = await http
                .put(
              uri,
              headers: header,
              encoding: Encoding.getByName("utf-8"),
              body: json.encode(body),
            )
                .timeout(timeoutDuration);
          }
          break;
        case RequestType.Get:
          {
            response = await http
                .get(
              uri,
              headers: header,
            )
                .timeout(timeoutDuration);
          }
          break;
        case RequestType.Delete:
          {
            response = await http
                .delete(
              uri,
              headers: header,
            )
                .timeout(timeoutDuration);
          }
          break;
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("✅ Request Success ( ${response.statusCode} ) ✅");
      } else if (response.statusCode == 401) {
        print("🚫🚫 Request Failed << Unauthorized >> ( ${response
            .statusCode} ) 🚫🚫");
        // print("${response.body})");
      } else {
        print("❌❌ Request Failed (${response.statusCode}) ❌❌");
        // print("${response.body})");
      }
    } on TimeoutException catch (error) {
      print("<< Timeout Exception >> ⌛⌛ ${error.toString()} ⌛⌛");
    } on SocketException catch (error) {
      print("<< Socket Exception >> 💣💣 ${error.toString()} 💣💣");
    } catch (error) {
      print("🚨🚨 ${error.toString()} 🚨🚨");
    }
    if (response != null) {
      dynamic stringJson = json.decode((response.body));
      // AppHelper.printObject(stringJson, "Request Fun");
      return stringJson;
    } else {
      return null;
    }
  }

  getUsers(BuildContext context) async {
    final res = await request(
      context,
      header: Headers.header,
      endPoint: EndPoints.getUsers,
      requestType: RequestType.Get,
    );
    return res;
  }
}