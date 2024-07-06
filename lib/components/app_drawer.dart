import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news/components/drawer_item.dart';
import 'package:news/models/api_response_controller.dart';
import 'package:news/utils/app_constants.dart';
import 'package:news/utils/subtopic_navitem_controller.dart';

import '../controllers/app_controller.dart';
import '../controllers/app_web_controller.dart';
import '../models/api_response.dart';
import '../utils/app_color_swatch.dart';

class AppDrawer {
  Widget getAppDrawer() {
    SubtopicNavController subtopicNavController = Get.find();
    ApiResponseController apiResponseController = Get.find();
    // List<Subtopic> savedSubtopics = PreferenceService().loadNavbarItems();

    showSnackBar() {
      final storage = GetStorage();
      if (storage.read("showNotification") == true) {
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

    return SafeArea(
      child: SizedBox(
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.only(
              bottom: 80.0, left: 20.0, right: 20.0, top: 60.0),
          child: Drawer(
            backgroundColor: AppColorSwatch.appDrawBgCOlor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      Row(
                        children: [
                          GetBuilder<SubtopicNavController>(
                              builder: (subTopNavController) {
                            return InkWell(
                              onTap: () {
                                showSnackBar();
                              },
                              child: const Icon(
                                Icons.close,
                                color: Color(0xFF666666),
                              ),
                            );
                          })
                        ],
                      )
                    ],
                  ),
                  const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.info_rounded,
                            size: 10.0,
                            color: Color(0xFFFFFFFF),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Expand a heading and switch on subheadings to subscribe.',
                            style: TextStyle(
                              fontSize: 10.0,
                              color: Color(0xFFFFFFFF),
                            ),
                          )
                        ],
                      )),
                  Flexible(
                    child: FutureBuilder(
                      builder:
                          (context, AsyncSnapshot<ApiResponse> responseSnap) {
                        if (responseSnap.connectionState !=
                                ConnectionState.none &&
                            responseSnap.hasData) {
                          ApiResponse apiResponse = responseSnap.data!;
                          return ListView.separated(
                            itemCount: apiResponse.menuItems!.length,
                            itemBuilder: (context, i) {
                              List<MenuItem> items = apiResponse.menuItems!;
                              return DrawerItem(menuItem: items[i]);
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Divider(
                                height: 4,
                                color: AppColorSwatch.appDrawBgCOlor,
                              );
                            },
                          );
                        }
                        return const CircularProgressIndicator();
                      },
                      future: apiResponseController.fetchTopics(),
                    ),
                  ),
                  //const Spacer(),
                  Column(
                    //mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 3),
                        child: AppController.to.copyRight(),
                      ),
                      Image.asset(
                        'assets/image/black_sport_news.png',
                        width: 120,
                        // height: 60,
                      ),

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Image.asset(
                      //       'assets/image/logo.png',
                      //       width: 120,
                      //       height: 60,
                      //     ),
                      // Row(
                      //   children: [
                      //     GetBuilder<SubtopicNavController>(
                      //         builder: (subTopNavController) {
                      //       return InkWell(
                      //         onTap: () {
                      //           showSnackBar();
                      //         },
                      //         child: const Text('KLAR', style: TextStyle(
                      //             fontSize: 18,
                      //             color: Colors.white,
                      //           ),
                      //         ),
                      //       );
                      //     }),
                      //     const SizedBox(width: 8),
                      //   ],
                      // )
                      //   ],
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 7.0, bottom: 10),
                      //   child: AppController.to.copyRight(),
                      // ),
                      // Divider(
                      //   color: Colors.grey.shade200,
                      //   height: 4,
                      // ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
