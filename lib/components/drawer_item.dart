import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../controllers/app_controller.dart';
import '../models/api_response.dart';
import '../models/api_response_controller.dart';
import '../models/subtopic.dart';
import '../services/preference_service.dart';
import '../utils/app_color_swatch.dart';
import '../utils/subtopic_navitem_controller.dart';

class DrawerItem extends StatefulWidget {
  final MenuItem menuItem;
  const DrawerItem({super.key, required this.menuItem});

  @override
  State<DrawerItem> createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  SubtopicNavController subtopicNavController = Get.find();
  ApiResponseController apiResponseController = Get.find();
  List<Subtopic> savedSubtopics = PreferenceService().loadNavbarItems();

  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 57, 67, 78),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: AppController.to.isSvg(widget.menuItem.iconSource!)
                      ? SvgPicture.network(
                          widget.menuItem.iconSource!,
                          height: 24.0,
                          width: 24.0,
                        )
                      : Image.network(
                          widget.menuItem.iconSource!,
                          height: 24.0,
                          width: 24.0,
                        ),
                ),
                title: Text(
                  widget.menuItem.name!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(
                  _isExpanded ? Icons.arrow_circle_up : Icons.arrow_circle_down,
                ),
                // IconButton(
                //   onPressed: () {
                //     setState(() {
                //       _isExpanded = !_isExpanded;
                //     });
                //   },
                //   icon: Icon(
                //     _isExpanded ? Icons.arrow_circle_up : Icons.arrow_circle_down,
                //   ),
                // ),
              ),
              if (_isExpanded)
                Container(
                  decoration: BoxDecoration(
                    color: AppColorSwatch.appBarColor,
                  ),
                  child: Column(
                    children: widget.menuItem.topics!.expand((topic) {
                      List<Widget> widgets = [];
                      //chips
                      widgets.add(Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Chip(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 4),
                              label: Text(
                                topic.highlights2 ?? '                ',
                                style: const TextStyle(fontSize: 12.0),
                              ),
                              color: const MaterialStatePropertyAll(
                                  AppColorSwatch.customWhite),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Adjust the radius as needed
                              ),
                            ),
                            const Spacer(),
                            Chip(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 4),
                              label: const Text(
                                'Favoriter',
                                style: TextStyle(fontSize: 12.0),
                              ),
                              color: const MaterialStatePropertyAll(
                                  AppColorSwatch.customWhite),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Adjust the radius as needed
                              ),
                            ),
                          ],
                        ),
                      ));

                      //list tile
                      widgets.addAll(topic.subtopics!.map((subtopic) {
                        savedSubtopics.forEach((savedSubtopic) {
                          if (savedSubtopic.subTopicId == subtopic.subTopicId) {
                            subtopic.isSwitchedOn.value = true;
                          }
                        });
                        return ListTile(
                          leading: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.white24,
                              radius: 16.0,
                              child: AppController.to.isSvg(subtopic.logo!)
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
                                  subtopicNavController.toggleSubtopic(
                                      subtopic, value);
                                },
                              ),
                            ),
                          ),
                        );
                      }));

                      return widgets;
                    }).toList(),
                  ),
                ),
            ],
          )),
    );
    // ExpansionTile(
    //   backgroundColor: Colors.black87,

    // );
  }
}
