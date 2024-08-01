import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  static AppController get to => Get.find();

  bool isSvg(String src) {
    return src.toLowerCase().endsWith('.svg');
  }

  final RxBool buttonDisabled = false.obs;
  final RxBool isDark = true.obs;

  void setButtonDisabled(bool value) {
    buttonDisabled.value = value;
  }

  void setIsDark(bool value) {
    isDark.value = value;
  }

  bool getIsDark() {
    return isDark.value;
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
