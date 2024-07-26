import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:news/services/preference_service.dart';
import '../utils/app_color_swatch.dart';
import '../utils/subtopic_navitem_controller.dart';
import 'bottom_navbar_item.dart';

class BottomNavbarSection extends StatelessWidget {
  final ValueChanged<BottomNavigationBarItem> onClick;

  const BottomNavbarSection({super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubtopicNavController>(builder: (navController) {
      var items = navController.getNavbarItems();

      bool change = false;
      if (navController.isRefresh.value) {
        if (navController.mItem.isNotEmpty) {
          int i = PreferenceService()
              .loadNavbarItems()
              .indexOf(navController.mItem.first);
          if (i > -1 && i < items.length) {
            navController.navItemPosition.value = i;
            change = true;
          } else {
            i = navController.navItemPosition.value;
          }
          if (i > -1 && i < items.length) {
            // navController.navItemPosition.value = i;
          } else {
            navController.navItemPosition.value = 0;
            change = true;
          }
        }
        onClick(items[navController.navItemPosition.value]);
        navController.isRefresh.value = false;
      }

      if (change) items = navController.getNavbarItems();

      if (items.isEmpty) {
        return Container(
          height: 90,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColorSwatch.customBlack[20],
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          child: const SizedBox.shrink(),
        );
      }
      return Container(
        height: 110,
        width: Get.width,
        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
        decoration: const BoxDecoration(),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xff262626),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          height: 110.0,
          width: double.infinity,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
            decoration: const BoxDecoration(
              color: Color(0xff262626),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: items
                    .map((item) => NewBottomNavigationBarItemWidget(
                          item,
                          items.indexOf(item),
                          (val) {
                            onClick(val);
                          },
                        ))
                    .toList(),
              ),
            ),
          ),
        ),
      );
    });
  }
}
