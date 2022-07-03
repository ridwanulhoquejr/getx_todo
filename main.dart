// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo/screens/HomeScreen.dart';

import 'constants/constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Getx Todo',
      theme: ThemeData(
        primaryColor: Constant.kPrimaryColor,
        scaffoldBackgroundColor: Constant.kPrimaryLightColor,
      ),
      home: HomeScreen(),
    );
  }
}
