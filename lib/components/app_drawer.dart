import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news/models/api_response_controller.dart';
import 'package:news/utils/app_constants.dart';
import 'package:news/utils/subtopic_navitem_controller.dart';

import '../controllers/app_controller.dart';
import '../controllers/app_web_controller.dart';
import '../models/api_response.dart';
import '../models/subtopic.dart';
import '../services/preference_service.dart';
import '../utils/app_color_swatch.dart';

class AppDrawer {
  Widget getAppDrawer() {
    SubtopicNavController subtopicNavController = Get.find();
    ApiResponseController apiResponseController = Get.find();
    List<Subtopic> savedSubtopics = PreferenceService().loadNavbarItems();

    showSnackBar() {
      final storage = GetStorage();
      if(storage.read("showNotification") == true) {

      Get.snackbar(
        'Loading',
        "Saving. Please wait...",
        colorText: Colors.white,
        backgroundColor: AppColorSwatch.appChipColor,
        snackPosition: SnackPosition.BOTTOM,
        showProgressIndicator: true,
      );
      storage.write("showNotification", false);
      storage.write("isFirstTime", false);
      }
      // static AppWebController get to => Get.put(AppWebController());

      final appWebController = Get.find<AppWebController>();
      appWebController.homeScaffoldKey.currentState!.closeDrawer();
      // subtopicNavController.
      subtopicNavController.toggleSaveButton(false);
      var items = subtopicNavController.getNavbarItems();
      // var subTopicId = items[0].subTopicId;
      subtopicNavController.toggleSelectedNavItem(0);
      String link = items[0].tooltip!;
      print(
          'this is link before the cut :: ${AppConstants.baseUrl}/news/${link}');
      // int lenghtOfString = link.length;
      if (link[link.length - 1] == '_') {
        link = link.substring(0, link.length - 1);
      }

      AppWebController.to.controller.value
          .loadRequest(Uri.parse('${AppConstants.baseUrl}/news/${link}'));
    }

    final storage = GetStorage();
    storage.writeIfNull("isFirstTime", true);
    storage.writeIfNull("showNotification", true);

    // bool isShowSaveButton = subtopicNavController.isShowSaveButton;

    return SizedBox(
      width: Get.width,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 56.0),
        child: Drawer(
          backgroundColor: AppColorSwatch.customBlack,
          child: Column(
            children: [
              DrawerHeader(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/image/logo.png',
                          width: 120,
                          height: 60,
                        ),
                        // if(storage.read("isFirstTime") )
                        GetBuilder<SubtopicNavController>(
                            builder: (subTopNavController) {
                          return 
                          // subTopNavController.isShowSaveButton
                          //     ? 
                              InkWell(
                                  onTap: () {
                                    showSnackBar();
                                  },
                                  child: const Text(
                                    'KLAR',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: AppColorSwatch.appChipColor,
                                    ),
                                  ),
                                );
                              // : const SizedBox();
                        })
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: AppController.to.copyRight(),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              Flexible(
                child: FutureBuilder(
                  builder: (context, AsyncSnapshot<ApiResponse> responseSnap) {
                    if (responseSnap.connectionState != ConnectionState.none &&
                        responseSnap.hasData) {
                      ApiResponse apiResponse = responseSnap.data!;
                      return ListView.separated(
                        itemCount: apiResponse.menuItems!.length,
                        itemBuilder: (context, i) {
                          List<MenuItem> items = apiResponse.menuItems!;
                          return ExpansionTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.white24,
                              child: AppController.to.isSvg(items[i].iconSource!)
                                  ? SvgPicture.network(
                                      items[i].iconSource!,
                                      height: 24.0,
                                      width: 24.0,
                                    )
                                  : Image.network(
                                      items[i].iconSource!,
                                      height: 24.0,
                                      width: 24.0,
                                    ),
                            ),
                            title: Text(
                              items[i].name!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            children: items[i].topics!.expand((topic) {
                              List<Widget> widgets = [];
                              //chips
                              widgets.add(Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Row(
                                  children: [
                                    Chip(
                                      label: Text(
                                        topic.highlights2 ?? '                ',
                                        style: const TextStyle(fontSize: 10.0),
                                      ),
                                      color: const MaterialStatePropertyAll(
                                          AppColorSwatch.appChipColor),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            20), // Adjust the radius as needed
                                      ),
                                    ),
                                    const Spacer(),
                                    Chip(
                                      label: const Text(
                                        'Favoriter',
                                        style: TextStyle(fontSize: 10.0),
                                      ),
                                      color: const MaterialStatePropertyAll(
                                          AppColorSwatch.appChipColor),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            20), // Adjust the radius as needed
                                      ),
                                    ),
                                  ],
                                ),
                              ));
      
                              //list tile
                              widgets.addAll(topic.subtopics!.map((subtopic) {
                                savedSubtopics.forEach((savedSubtopic) {
                                  if (savedSubtopic.subTopicId ==
                                      subtopic.subTopicId) {
                                    subtopic.isSwitchedOn.value = true;
                                  }
                                });
                                return ListTile(
                                  leading: Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white24,
                                      radius: 16.0,
                                      child:
                                          AppController.to.isSvg(subtopic.logo!)
                                              ? SvgPicture.network(
                                                  subtopic.logo!,
                                                  height: 24.0,
                                                  width: 24.0,
                                                )
                                              : Image.network(
                                                  subtopic.logo!,
                                                  height: 24.0,
                                                  width: 24.0,
                                                ),
                                    ),
                                  ),
                                  title: Text(
                                    subtopic.name!,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  trailing: Transform.scale(
                                    scaleX: 0.7,
                                    scaleY: 0.7,
                                    child: Obx(
                                      () => Switch(
                                        value: subtopic.isSwitchedOn.value,
                                        onChanged: (bool value) {
                                          subtopic.isSwitchedOn.value = value;
                                          subtopicNavController.toggleSubtopic(
                                              subtopic, value);
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              }));
      
                              return widgets;
                            }).toList(),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                      );
                      ;
                    }
                    return const CircularProgressIndicator();
                  },
                  future: apiResponseController.fetchTopics(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
