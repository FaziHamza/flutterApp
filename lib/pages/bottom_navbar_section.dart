import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../utils/app_color_swatch.dart';
import '../utils/subtopic_navitem_controller.dart';
import 'bottom_navbar_item.dart';

class BottomNavbarSection extends StatelessWidget {
  final ValueChanged<bool>? onClick;
  const BottomNavbarSection({super.key, this.onClick});

  // final SubtopicNavController navController =
  //   Get.put(SubtopicNavController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubtopicNavController>(builder: (navController) {
      var items = navController.getNavbarItems();
      if (items.isEmpty) {
        return Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: AppColorSwatch.customBlack[20],
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            ),
          ),
          child: const SizedBox.shrink(),
        );
      }
      return Container(
        height: 56,
        width: Get.width,
        decoration: const BoxDecoration(
            // color: Colors.white,
            ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 57, 67, 78),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(35),
              topLeft: Radius.circular(35),
            ),
          ),
          height: 56.0,
          width: double.infinity,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            decoration: const BoxDecoration(
              // color: AppColorSwatch.customBlack[80],
              // color: Colors.black,
              color: Color.fromARGB(255, 57, 67, 78),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5)),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: items
                    .map(
                      (item) => BottomNavigationBarItemWidget(
                    item,
                    items.indexOf(item),
                        (val) {
                      onClick!(val);
                      print("this is the value of on click:: $val");
                    },
                  ),
                )
                    .toList(),
              ),
            ),
          ),
        ),
      );
    });
  }
}
