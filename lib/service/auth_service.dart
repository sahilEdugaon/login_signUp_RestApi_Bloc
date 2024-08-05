
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lovej/utils/snack_bar.dart';

class AuthService {
  String urlLogin = "https://b2b.lovoj.com/api/v1/auth/login";
  String urlSignUp = "https://b2b.lovoj.com/api/v1/auth/createStore";
  String otpUrl = "https://b2b.lovoj.com/api/v1/auth/checkemail";

  Future<http.Response?> loginService(Map<String,dynamic>data,BuildContext context) async {
    print('data-$data');
    try {
      http.Response response = await http.post(
        Uri.parse(urlLogin),
        // headers: {
        //   'Content-Type': 'application/json',
        //   'Accept': '*/*',
        //   'Connection': 'keep-alive',
        // },
        body: data,
      );
      print('response-$response');
      print('statusCode-${response.statusCode}');
      print('body-${response.body}');
      if (response.statusCode == 200) {
        return response;
      }
      else {
        print('else');
        final responseBody = json.decode(response.body);
        print(responseBody);

        final errorMessage = responseBody['message'] ?? 'Unknown error occurred';
        print(errorMessage);
        snackBar(context, errorMessage, Colors.white, Colors.red);

        throw http.Response(errorMessage, response.statusCode, reasonPhrase: response.reasonPhrase);

      }
    } catch (err) {
      print('Exception-$err');
      throw Exception(err);
    }
  }

  Future<http.Response?> otpService(Map<String,dynamic>data) async {

    print('data-$data');
    print(json.encode(data));
    try {
      http.Response response = await http.post(
        Uri.parse(otpUrl),
        // headers: {
        //   'Content-Type': 'application/json',
        //   'Accept': '*/*',
        //   'Connection': 'keep-alive',
        // },
        body: data,
      );
      print('response-$response');
      print('statusCode-${response.statusCode}');
      print('body-${response.body}');
      if (response.statusCode == 200) {
        return response;
      }
    } on SocketException catch (e) {
      print('SocketException: $e');
      // Handle network errors here
    } on HttpException catch (e) {
      print('HttpException: $e');
      // Handle HTTP errors here
    } on FormatException catch (e) {
      print('FormatException: $e');
      // Handle data format errors here
    } catch (err) {
      print('Exception-$err');
      throw Exception(err);
    }
  }

  Future<http.Response?> createAccountService(Map<String,dynamic> data,BuildContext context) async {
    print('data=$data');
    print('data=${json.encode(data)}');
    // var body = utf8.encode(json.encode(data));
    try {
      http.Response response = await http.post(
        Uri.parse(urlSignUp),
        // headers: {
        //   'Content-Type': 'multipart/form-data; boundary=<calculated when request is sent>',
        //   'Accept': '*/*',
        //   'Connection': 'keep-alive',
        //   'Accept-Encoding': 'gzip, deflate, br',
        // },
         body: data
        // body: json.encode(data),
      );
      print('response-$response');
      print('response-${response.body}');
      print('response-${response.statusCode}');
      if (response.statusCode == 200) {
        return response;
      }
      else {
        print('else');
        final responseBody = json.decode(response.body);
        print(responseBody);

        final errorMessage = responseBody['message'] ?? 'Unknown error occurred';
        print(errorMessage);
        snackBar(context, errorMessage, Colors.white, Colors.red);

        throw http.Response(errorMessage, response.statusCode, reasonPhrase: response.reasonPhrase);

     }
    } catch (err) {
      print('Exception-$err');
      throw Exception(err);
    }
  }
}

