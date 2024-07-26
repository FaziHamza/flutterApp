import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/models/subtopic.dart';
import '../utils/subtopic_navitem_controller.dart';

class NewBottomNavigationBarItemWidget extends StatelessWidget {
  final SubtopicNavController navController = Get.find();
  final BottomNavigationBarItem item;
  final int navItemPosition;
  final ValueChanged<BottomNavigationBarItem>? isClicked;

  NewBottomNavigationBarItemWidget(
      this.item, this.navItemPosition, this.isClicked,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: InkWell(
        onTap: () {
          Subtopic subtopic = Subtopic.fromRawJson(item.tooltip ?? '');
          navController.toggleSelectedNavItem(navItemPosition, subtopic);
          isClicked!(item);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: item.backgroundColor,
                borderRadius: BorderRadius.circular(20.0),
                // Adjust the radius as needed
                border: Border.all(color: Colors.white, width: 1.0),
              ),
              child: Text(
                item.label ?? '',
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: item.backgroundColor == Colors.white
                      ? Colors.black
                      : Colors.white,
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
