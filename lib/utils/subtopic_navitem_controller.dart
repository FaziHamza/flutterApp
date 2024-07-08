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

  void toggleSelectedNavItem(index, ) {
    // final box = Hive.box("");
    // final box = Hive.box('navbarBox');
    // List<Subtopic> listofsubtopic = box.values.cast<Subtopic>().toList();
    // for(var subTopic in listofsubtopic) {
    //   if(subTopic.subTopicId == subtopicId){

    //   }
    // }
    // int newIndex = 0;
    // for(int i=0; i< listofsubtopic.length; i++){
    //   final topic = listofsubtopic[i];
    //   if(topic.subTopicId == subtopicId) {
    //     newIndex = i;
    //   }
    // }
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
        label: 
        //activeSubtopics[navItemPosition.value] == subtopic
         //   ? subtopic.name
         //   : ''
         subtopic.name,
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
        key: Key(subtopic.keyword.toString()),
        backgroundColor: activeSubtopics[navItemPosition.value] == subtopic ? const Color(0xff365880) : Colors.white
      );
    }).toList();
  }
}
