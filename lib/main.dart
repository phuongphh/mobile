import 'dart:io';
import 'package:Toot/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Toot/routes.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:user_repository/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //final userRepository = UserRepository();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(App()));
}

