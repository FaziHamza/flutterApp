import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:news/pages/home_page.dart';

import '../controllers/app_controller.dart';
import '../models/api_response.dart';
import '../models/api_response_controller.dart';
import '../models/subtopic.dart';
import '../services/preference_service.dart';
import '../utils/app_color_swatch.dart';
import '../utils/subtopic_navitem_controller.dart';

class PreferencePage extends StatelessWidget {
  PreferencePage({super.key});

  final SubtopicNavController navController = Get.find();
  final ApiResponseController apiResponseController = Get.find();
  final List<Subtopic> savedSubtopics = PreferenceService().loadNavbarItems();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColorSwatch.appBarColor,
        title: Image.asset(
          'assets/image/logo.png',
          height: 36.0,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: SvgPicture.asset(
              'assets/image/sweden.svg',
              height: 36.0,
              width: 36.0,
            ),
          ),
          TextButton(
            onPressed: () async {
              if (SubtopicNavController.to.activeSubtopics.length >= 2) {
                PreferenceService().savedPreferencePage(true);
                Get.delete<SubtopicNavController>();

                Get.snackbar(
                  'Loading',
                  'Saving. Please wait...',
                  showProgressIndicator: true,
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppColorSwatch.appChipColor,
                  duration: const Duration(seconds: 3),
                );
                await Future.delayed(const Duration(seconds: 3), () {
                  Get.offAll(HomePage());
                });
              } else {
                Get.snackbar(
                  'Warning',
                  'Du måste välja minst ett favoritämne.',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppColorSwatch.appChipColor,
                  duration: const Duration(seconds: 3),
                );
              }
            },
            child: GetBuilder<AppController>(
              builder: (controller) {
                return Text(
                  controller.buttonDisabled.value ? 'läser in...' : 'KLAR',
                  style: const TextStyle(
                    color: AppColorSwatch.appChipColor,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 16.0,
                    color: Colors.white60,
                  ),
                  SizedBox(width: 48.0),
                  Flexible(
                    child: Text(
                      'Välj ditt nya favoritämne för att få omedelbara uppdateringar.',
                      softWrap: true,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.white60,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Flexible(
              child: FutureBuilder(
                builder: (context, AsyncSnapshot<ApiResponse> responseSnap) {
                  if (responseSnap.connectionState != ConnectionState.none &&
                      responseSnap.hasData) {
                    ApiResponse apiResponse = responseSnap.data!;
                    return Container(
                      color: Colors.white10,
                      child: ListView.separated(
                        itemCount: apiResponse.menuItems!.length,
                        itemBuilder: (context, i) {
                          List<MenuItem> items = apiResponse.menuItems!;
                          return ExpansionTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.white24,
                              child:
                                  AppController.to.isSvg(items[i].iconSource!)
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
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
                                          SubtopicNavController.to
                                              .toggleSubtopic(subtopic, value);
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
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                },
                future: apiResponseController.fetchTopics(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() {
        var items = navController.getNavbarItems([]);
        if (items.isEmpty) {
          return const SizedBox.shrink();
        }
        return Container(
          decoration: BoxDecoration(
            color: AppColorSwatch.customBlack[50],
          ),
          height: 56.0,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: items
                  .map(
                    (item) => BottomNavigationBarItemWidgetForPreference(
                        item, items.indexOf(item)),
                  )
                  .toList(),
            ),
          ),
        );
      }),
    );
  }
}

// Widget for each item in the scrollable bottom navigation bar
class BottomNavigationBarItemWidgetForPreference extends StatelessWidget {
  final BottomNavigationBarItem item;
  final int navItemPosition;

  const BottomNavigationBarItemWidgetForPreference(
      this.item, this.navItemPosition,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(32.0)),
            border: Border.all(color: Colors.white)),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: InkWell(
            onTap: () {
              SubtopicNavController.to.toggleSelectedNavItem(navItemPosition, );
            },
            child: Row(
              children: <Widget>[
                item.icon,
                Text(
                  item.label ?? '',
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
