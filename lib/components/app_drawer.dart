import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/components/drawer_item.dart';
import 'package:news/models/api_response_controller.dart';
import 'package:news/utils/CustomColors.dart';
import 'package:news/utils/subtopic_navitem_controller.dart';
import '../controllers/app_controller.dart';
import '../models/api_response.dart';
import '../utils/app_color_swatch.dart';
import '../models/subtopic.dart';
import '../utils/theme_toggle.dart';

class AppDrawer {
  Widget getAppDrawer(
      bool isLightMode,
      CustomColors customColors,
      ValueChanged<Subtopic>? onClick,
      ValueChanged<bool> onClose,
      GestureTapCallback onTap) {
    ApiResponseController apiResponseController = Get.find();

    return SafeArea(
      child: SizedBox(
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.only(
              bottom: 100.0, left: 20.0, right: 20.0, top: 70.0),
          child: Drawer(
            backgroundColor: customColors.bgContainerColor,
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
                                onClose(true);
                              },
                              child: Icon(
                                Icons.close,
                                color: customColors.iconTextColor ??
                                    const Color(0xFF666666),
                              ),
                            );
                          })
                        ],
                      )
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        'Customize your theme',
                        style: TextStyle(
                          fontSize: 11.0,
                          color: customColors.titleTextColor ??
                              const Color(0xFFFFFFFF),
                        ),
                        textAlign: TextAlign.center,
                      )),
                  ThemeToggleSwitch(isLightMode: isLightMode, onTap: onTap),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.info_rounded,
                            size: 10.0,
                            color: customColors.titleTextColor ??
                                const Color(0xFFFFFFFF),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Expand a heading and switch on subheadings to subscribe.',
                            style: TextStyle(
                              fontSize: 11.0,
                              color: customColors.titleTextColor ??
                                  const Color(0xFFFFFFFF),
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
                              return DrawerItem(
                                  menuItem: items[i], onClick: onClick);
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider(
                                height: 4,
                                color: customColors.bgContainerColor ??
                                    AppColorSwatch.bgContainerColorDark,
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
                        child: AppController.to.copyRight(
                            customColors.titleTextColor ?? Colors.white54),
                      ),
                      Image.asset(
                        'assets/image/black_sport_news.png',
                        width: 120,
                        // height: 60,
                      ),
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
