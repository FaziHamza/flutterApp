import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  static AppController get to => Get.find();

  bool isSvg(String src) {
    return src.toLowerCase().endsWith('.svg');
  }

  final RxBool buttonDisabled = false.obs;

  void setButtonDisabled(bool value) {
    buttonDisabled.value = value;
  }

  Widget copyRight(Color mColor) {
    return Text(
      '©${DateTime.now().year} www.sportblitznews.se | All Rights Reserved.',
      style: TextStyle(
        fontSize: 10.0,
        color: mColor,
      ),
      textAlign: TextAlign.center,
    );
  }
}
