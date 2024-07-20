import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:news/models/subtopic.dart';

import '../utils/app_color_swatch.dart';
import '../utils/subtopic_navitem_controller.dart';
import 'bottom_navbar_item.dart';

class BottomNavbarSection extends StatelessWidget {
  final ValueChanged<BottomNavigationBarItem>? onClick;
  List<Subtopic> savedSubtopics = [];
 // const BottomNavbarSection({super.key, this.onClick});

  BottomNavbarSection({super.key, required this.savedSubtopics, this.onClick});

  // final SubtopicNavController navController =
  //   Get.put(SubtopicNavController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubtopicNavController>(builder: (navController) {
      var items = navController.getNavbarItems(savedSubtopics);
      if (items.isEmpty) {
        return Container(
          height: 90,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColorSwatch.customBlack[20],
           borderRadius: const BorderRadius.all( Radius.circular(15)
             // topRight: Radius.circular(15),
             // topLeft: Radius.circular(15),
            ),
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
         // padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: const BoxDecoration(
            color: Color(0xff262626),
            borderRadius: BorderRadius.all( Radius.circular(15)
            //  topRight: Radius.circular(15),
            //  topLeft: Radius.circular(15),
            ),
          ),
          height: 110.0,
          width: double.infinity,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
            decoration: const BoxDecoration(
              color: Color(0xff262626),
              borderRadius: BorderRadius.all( Radius.circular(15)),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: items
                    .map((item) => NewBottomNavigationBarItemWidget(
                    item,items.indexOf(item),(val) {
                      onClick!(item);
                      print("this is the value of on click:: $val");
                    },
                  ),
                ).toList(),
              ),
            ),
          ),
        ),
      );
    });
  }
}
