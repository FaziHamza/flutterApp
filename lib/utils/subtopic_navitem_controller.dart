import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:news/controllers/app_controller.dart';
import 'package:news/services/preference_service.dart';
import 'package:news/services/subtopic_service.dart';

import '../models/subtopic.dart';

class SubtopicNavController extends GetxController {
  static SubtopicNavController get to => Get.put(SubtopicNavController());

  // List to hold active subtopics
  var activeSubtopics = <Subtopic>[].obs;
  var navItemPosition = 0.obs;
  var navItemTopic = ''.obs;
  var isPrefPage = false.obs;
  bool _isShowSaveButton = false;
  bool get isShowSaveButton => _isShowSaveButton;

  toggleSaveButton(bool value) {
    _isShowSaveButton = value;
    update();
  }

  // Method to toggle subtopic
  void toggleSubtopic(Subtopic subtopic, bool isActive) async {
    if (isActive) {
      activeSubtopics.add(subtopic);
      PreferenceService().saveSubtopic(subtopic);
      SubtopicService().subscribeToSubtopic(subtopic.subTopicId!);
      update();
    } else {
      activeSubtopics.remove(subtopic);
      PreferenceService().removeSubtopic(subtopic);
      SubtopicService().unsubscribeToSubtopic(subtopic.subTopicId!);
      update();
    }

    if (activeSubtopics.length >= 2) {
      PreferenceService().savedPreferencePage(true);
    } else {
      PreferenceService().savedPreferencePage(false);
    }
    update();
  }

  void toggleSelectedNavItem(index) {
    navItemPosition.value = index;
    update();
  }

  void toggleSelectedNavTopic(topic) {
    navItemTopic.value = topic;
    update();
  }

  // Method to build the bottom navigation bar items
  List<BottomNavigationBarItem> getNavbarItems() {
    activeSubtopics.value = PreferenceService().loadNavbarItems();
    return activeSubtopics.map((subtopic) {
      return BottomNavigationBarItem(
        // You can customize this icon
        label: activeSubtopics[navItemPosition.value] == subtopic
            ? subtopic.name
            : '',
        icon: AppController.to.isSvg(subtopic.logo!)
            ? SvgPicture.network(
                subtopic.logo!,
                height: 32.0,
                width: 32.0,
              )
            : Image.network(
                subtopic.logo!,
                height: 32.0,
                width: 32.0,
              ),
        tooltip: '${subtopic.name!.toLowerCase().replaceAll(' ', '_')}_',
      );
    }).toList();
  }
}
