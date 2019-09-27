import 'dart:async';
import 'dart:io';

import 'package:dextraservice/Model/User.dart';
import 'package:dextraservice/Network/network-util.dart';

class RestDataResource {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "https://dextra.hattadev.com/public";
  static final LOGIN_URL = BASE_URL + "auth/login";
  static final _API_KEY = "";

  Future<User> login(String username, String password) {
    var headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    var body = {"username": username, "password": password};

    return _netUtil
        .post(LOGIN_URL, body: body, headers: headers)
        .then((dynamic res) {
      print(res.toString());

      if (res["token"] == null) throw new Exception('Incorrect login!');

      return new User.map(res);
    });
  }
}