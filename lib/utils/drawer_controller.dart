import 'package:get/get.dart';

class CustomDrawerController extends GetxController {
  RxInt currentExpandedPanelIndex = (-1).obs;

  void setExpandedPanelIndex(int index) {
    if (currentExpandedPanelIndex.value == index) {
      // Clicking the same panel that is open will close it
      currentExpandedPanelIndex.value = -1;
    } else {
      currentExpandedPanelIndex.value = index;
    }
    update();
  }
}
