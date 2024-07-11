import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/utils/app_constants.dart';

import '../controllers/app_web_controller.dart';
import '../utils/subtopic_navitem_controller.dart';

class BottomNavigationBarItemWidget extends StatelessWidget {
  final SubtopicNavController navController = Get.find();
  final BottomNavigationBarItem item;
  final int navItemPosition;
  final ValueChanged<bool>? isClicked;
  

  BottomNavigationBarItemWidget(this.item, this.navItemPosition, this.isClicked,  
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        decoration: const BoxDecoration(
          //  color: Colors.white,
            shape: BoxShape.rectangle,
          //  borderRadius: const BorderRadius.all(Radius.circular(32.0)),
          //  border: Border.all(color: Colors.white)
          ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: InkWell(
            onTap: () {
              navController.toggleSelectedNavItem(navItemPosition,);
              navController.toggleSaveButton(false);
              isClicked!(true);
            },
            child: Column(
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


class NewBottomNavigationBarItemWidget extends StatelessWidget {
  final SubtopicNavController navController = Get.find();
  final BottomNavigationBarItem item;
  final int navItemPosition;
  final ValueChanged<bool>? isClicked;

  NewBottomNavigationBarItemWidget(this.item, this.navItemPosition, this.isClicked, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: InkWell(
        onTap: () {
          navController.toggleSelectedNavItem(navItemPosition);
          navController.toggleSaveButton(false);
          isClicked!(true);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Circular icon with border
            Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1.0),
      ),
      child: CircleAvatar(
        backgroundColor: item.backgroundColor,
        child: ClipOval(
          child: SizedBox(
            height: 50,
            width: 50,
            child: FittedBox(
              fit: BoxFit.contain,
              child: item.icon,
            ),
          ),
        ),
      ),
    ),
            const SizedBox(height: 3.0), // Space between icon and text
            // Text with rounded background
            Container(
              width: 60,
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: item.backgroundColor,
                borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
                border: Border.all(color: Colors.white, width: 1.0),
              ),
              child: Text(
                item.label ?? '',
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: item.backgroundColor == Colors.white ? Colors.black : Colors.white,
                  fontSize: 9.0, // Adjust the font size as needed
                  
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}