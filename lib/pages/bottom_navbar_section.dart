import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_color_swatch.dart';
import '../utils/subtopic_navitem_controller.dart';
import 'bottom_navbar_item.dart';

class BottomNavbarSection extends StatelessWidget {
  const BottomNavbarSection({super.key});

  // final SubtopicNavController navController =
  //   Get.put(SubtopicNavController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubtopicNavController>(builder: (navController) {
      var items = navController.getNavbarItems();
      if (items.isEmpty) {
        return Container(
          height: 56,
          decoration: BoxDecoration(
            color: AppColorSwatch.customBlack[50],
          ),
          child: const SizedBox.shrink(),
        );
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
                .map((item) =>
                    BottomNavigationBarItemWidget(item, items.indexOf(item)))
                .toList(),
          ),
        ),
      );
    });
  }
}
