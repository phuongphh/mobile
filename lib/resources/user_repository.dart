import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:Toot/models/app_const.dart';
import 'dart:convert';
import 'package:Toot/models/globals.dart' as globals;

class UserRepository {
  Future<String> authenticate({
    @required String email,
    @required String password,
  }) async {
    final response = await http.post('$SERVER_URL/auth/local',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'identifier': email,
          'password': password,
        }));

    if (response.statusCode == 200) {
      return json.decode(response.body)["jwt"];
    } else
      return null;
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    globals.storage.deleteAll();
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    await globals.storage.write(key: "jwt", value: token);
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    String token = await globals.storage.read(key: "jwt");
    if (token == null)
      return false;
    else
      return true;
  }
}
