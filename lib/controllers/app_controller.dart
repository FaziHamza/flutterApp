import 'package:flutter/material.dart';
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

  Widget copyRight() {
    return Row(
      children: [
        const Icon(
          Icons.copyright_rounded,
          size: 10.0,
          color: Colors.white54,
        ),
        Text(
          '${DateTime.now().year} www.sportblitznews.se | All Rights Reserved.',
          style: const TextStyle(
            fontSize: 10.0,
            color: Colors.white54,
          ),
        ),
      ],
    );
  }
}
