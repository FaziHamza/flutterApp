import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/app_web_controller.dart';
import '../utils/subtopic_navitem_controller.dart';

class BottomNavigationBarItemWidget extends StatelessWidget {
  final SubtopicNavController navController = Get.find();
  final BottomNavigationBarItem item;
  final int navItemPosition;

  BottomNavigationBarItemWidget(this.item, this.navItemPosition, {super.key});

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
              navController.toggleSelectedNavItem(navItemPosition);
              navController.toggleSaveButton(false);
              String link = item.tooltip!;
              print(
                  'this is link before the cut :: https://sportblitznews.se/news/${link}');
              // int lenghtOfString = link.length;
              if (link[link.length - 1] == '_') {
                link = link.substring(0, link.length - 1);
              }

              AppWebController.to.controller.value.loadRequest(
                  Uri.parse('https://sportblitznews.se/news/${link}'));
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
