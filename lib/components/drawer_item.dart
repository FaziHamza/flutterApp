import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../controllers/app_controller.dart';
import '../models/api_response.dart';
import '../models/api_response_controller.dart';
import '../models/subtopic.dart';
import '../services/preference_service.dart';
import '../utils/CustomColors.dart';
import '../utils/app_color_swatch.dart';
import '../utils/subtopic_navitem_controller.dart';

class DrawerItem extends StatefulWidget {
  final MenuItem menuItem;
  final ValueChanged<Subtopic>? onClick;

  const DrawerItem({super.key, required this.menuItem, this.onClick});

  @override
  State<DrawerItem> createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  SubtopicNavController subtopicNavController = Get.find();
  ApiResponseController apiResponseController = Get.find();

  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return InkWell(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Container(
          decoration: BoxDecoration(
              color: customColors.cardItemColor ?? Color(0xFF262626),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColorSwatch.blue,
                  child: AppController.to.isSvg(widget.menuItem.iconSource!)
                      ? SvgPicture.network(
                          widget.menuItem.iconSource!,
                          height: 26.0,
                          width: 26.0,
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
                      fontWeight: FontWeight.bold, fontSize: 14.0),
                ),
                trailing: Icon(
                  _isExpanded
                      ? Icons.arrow_drop_up_rounded
                      : Icons.arrow_drop_down_rounded,
                ),
              ),
              if (_isExpanded)
                Container(
                  decoration: BoxDecoration(
                      color: customColors.cardItemColor,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Column(
                    children: widget.menuItem.topics!.expand((topic) {
                      List<Widget> widgets = [];
                      //chips
                      // widgets.add(Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      //   child: Row(
                      //     children: [
                      //       Chip(
                      //         padding: const EdgeInsets.symmetric(
                      //             horizontal: 15, vertical: 4),
                      //         label: Text(
                      //           topic.highlights2 ?? '                ',
                      //           style: TextStyle(
                      //               fontSize: 12.0,
                      //               color: customColors.badgeTextColor),
                      //         ),
                      //         color: WidgetStatePropertyAll(
                      //             customColors.badgeColor ??
                      //                 Color.fromRGBO(79, 79, 80, 1)),
                      //         shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(20)),
                      //         side: BorderSide.none,
                      //         backgroundColor: customColors.badgeColor ??
                      //             const Color.fromRGBO(79, 79, 80, 1),
                      //       ),
                      //       const Spacer(),
                      //       Chip(
                      //         padding: const EdgeInsets.symmetric(
                      //             horizontal: 15, vertical: 4),
                      //         label: Text(
                      //           'Favoriter ♥️',
                      //           style: TextStyle(
                      //               fontSize: 12.0,
                      //               color: customColors.badgeTextColor),
                      //         ),
                      //         color: WidgetStatePropertyAll(
                      //             customColors.badgeColor ??
                      //                 Color.fromRGBO(79, 79, 80, 1)),
                      //         shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(20)),
                      //         side: BorderSide.none,
                      //         backgroundColor: customColors.badgeColor ??
                      //             const Color.fromRGBO(79, 79, 80, 1),
                      //       ),
                      //     ],
                      //   ),
                      // ));
                      List<Subtopic> savedSubtopics =
                          PreferenceService().loadNavbarItems();
                      //list tile
                      widgets.addAll(topic.subtopics!.map((subtopic) {
                        for (var savedSubtopic in savedSubtopics) {
                          if (savedSubtopic.subTopicId == subtopic.subTopicId) {
                            subtopic.isSwitchedOn.value = true;
                          }
                        }
                        return Column(
                          children: [
                            Divider(
                                height: 0.5,
                                color:  customColors.lineItemColor  ??
                                    AppColorSwatch.bgContainerColorDark),
                            ListTile(
                              leading: Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 16.0,
                                    child:
                                        AppController.to.isSvg(subtopic.logo!)
                                            ? SvgPicture.network(
                                                subtopic.logo!,
                                                height: 22.0,
                                                width: 22.0,
                                              )
                                            : Image.network(
                                                subtopic.logo!,
                                                height: 22.0,
                                                width: 22.0,
                                              )),
                              ),
                              title: Text(
                                subtopic.name!,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: customColors.titleTextColor,
                                fontWeight: FontWeight.bold),
                              ),
                              trailing: Transform.scale(
                                scaleX: 0.6,
                                scaleY: 0.6,
                                child: Obx(
                                  () => Switch(
                                    value: subtopic.isSwitchedOn.value,
                                    onChanged: (bool value) {
                                      subtopic.isSwitchedOn.value = value;
                                      subtopicNavController.toggleSubtopic(
                                          subtopic, value);
                                      if (value) {
                                        widget.onClick!(subtopic);
                                      }
                                    },
                                    activeTrackColor: const Color(0xFF365880),
                                    inactiveThumbColor:
                                        customColors.switchColor ??
                                            const Color(0xFFA7A7A7),
                                  ),
                                ),
                              ),
                              contentPadding: const EdgeInsets.only(left: 40.0),
                            )
                          ],
                        );
                      }));
                      return widgets;
                    }).toList(),
                  ),
                ),
            ],
          )),
    );
  }
}
