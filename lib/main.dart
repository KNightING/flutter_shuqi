import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';

import 'package:shuqi/app/app_scene.dart';

import 'package:dcc/chinese_converter.dart';

void main() {
  runApp(AppScene());

  ChineseConverter.withReady(() {
    print('OKOKOK!!!');
  });

  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}
