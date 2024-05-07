import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:gymsocial/core/class/request_status.dart';
import 'package:http/http.dart' as http;

class Crud {
  Future<Either<RequestStatus, Map>> postData(String linkurl, Map data) async {
    try {
      var response = await http
          .post(Uri.parse(linkurl), body: data)
          .timeout(const Duration(seconds: 5), onTimeout: () {
        return http.Response('Error', 408);
      });
      // print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responseBody = jsonDecode(response.body);
        return Right(responseBody);
      } else {
        return const Left(RequestStatus.serverFailure);
      }
    } catch (e) {
      debugPrint("Crud Error: $e");
      return const Left(RequestStatus.serveException);
    }
  }
}
