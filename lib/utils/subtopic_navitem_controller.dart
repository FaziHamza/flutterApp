import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:news/controllers/app_controller.dart';
import 'package:news/services/preference_service.dart';
import 'package:news/services/subtopic_service.dart';
import '../models/subtopic.dart';

class SubtopicNavController extends GetxController {
  static SubtopicNavController get to => Get.put(SubtopicNavController());

  var activeSubtopics = <Subtopic>[].obs;
  var navItemPosition = 0.obs;
  var isRefresh = false.obs;
  var mItem = <Subtopic>[].obs;

  void menuUpdate() {
    update();
  }

  // Method to toggle subtopic
  void toggleSubtopic(Subtopic subtopic, bool isActive) async {
    if (isActive) {
      activeSubtopics.add(subtopic);
      PreferenceService().saveSubtopic(subtopic);
      setPosition(subtopic, isActive);
      SubtopicService().subscribeToSubtopic(subtopic.subTopicId!);
    } else {
      activeSubtopics.remove(subtopic);
      PreferenceService().removeSubtopic(subtopic, true);
      setPosition(subtopic, isActive);
      SubtopicService().unsubscribeToSubtopic(subtopic.subTopicId!);
    }
    update();
  }

  void setPosition(Subtopic subtopic, bool isActive) {
    if (isActive) {
      isRefresh.value = true;
      navItemPosition.value = activeSubtopics.indexOf(subtopic);
      mItem.value = [subtopic];
    } else {
      isRefresh.value = true;
      if (subtopic == mItem.first) {
        navItemPosition.value = 0;
        if (activeSubtopics.isNotEmpty) {
          mItem.value = [activeSubtopics.first];
        }
      }
    }
  }

  void toggleSelectedNavItem(index, item) {
    if (index < activeSubtopics.length && index > -1) {
      navItemPosition.value = index;
      mItem.value = [item];
      update();
    }
  }

  List<BottomNavigationBarItem> getNavbarItems() {
    activeSubtopics.value = PreferenceService().loadNavbarItems();
    return activeSubtopics.map((subtopic) {
      return BottomNavigationBarItem(
          label: subtopic.name,
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
          tooltip: subtopic.toRawJson(),
          key: Key(subtopic.keyword.toString()),
          backgroundColor: navItemPosition.value < activeSubtopics.length &&
                  activeSubtopics[navItemPosition.value] == subtopic
              ? const Color(0xff365880)
              : Colors.white);
    }).toList();
  }
}
