import 'package:flutter/material.dart';

import 'CustomColors.dart';

class ThemeToggleSwitch extends StatefulWidget {
  final GestureTapCallback onTap;
  bool isLightMode = true;

  ThemeToggleSwitch({
    super.key, required this.isLightMode, required this.onTap
  });

  @override
  State<ThemeToggleSwitch> createState() => _ThemeToggleSwitchState();
}

class _ThemeToggleSwitchState extends State<ThemeToggleSwitch> {

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    return Center(
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: 100, // Increased width to accommodate margins
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: customColors.cardItemColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Light',
                    style: TextStyle(
                        color: widget.isLightMode ? Colors.white : Colors.white,
                        fontWeight:
                        widget.isLightMode ? FontWeight.bold : FontWeight.normal,
                        fontSize: 10),
                  ),
                  Text(
                    'Dark',
                    style: TextStyle(
                        color: !widget.isLightMode ? Colors.white : Colors.black,
                        fontWeight:
                        !widget.isLightMode ? FontWeight.bold : FontWeight.normal,
                        fontSize: 10),
                  ),
                ],
              ),
              AnimatedAlign(
                duration: Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                alignment:
                widget.isLightMode ? Alignment.centerLeft : Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  // Margin around the selected button
                  width: 45,
                  // Adjusted width to accommodate margins
                  height: 25,
                  decoration: BoxDecoration(
                    color: const Color(0xff365880) ,
                    borderRadius: BorderRadius.circular(25),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.black.withOpacity(0.2),
                    //     blurRadius: 10,
                    //     offset: Offset(0, 5),
                    //   ),
                    // ],
                  ),
                  child: Center(
                    child: Text(
                      widget.isLightMode ? 'Light' : 'Dark',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}