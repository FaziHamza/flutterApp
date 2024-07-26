import 'package:flutter/material.dart';

class CustomColors extends ThemeExtension<CustomColors> {
  final Color? cardColor;
  final Color? topBarColor;
  final Color? bgContainerColor;
  final Color? bgBarColor;
  final Color? badgeColor;
  final Color? titleTextColor;
  final Color? bodyTextColor;

  CustomColors({
    this.cardColor,
    this.topBarColor,
    this.bgBarColor,
    this.badgeColor,
    this.bgContainerColor,
    this.titleTextColor,
    this.bodyTextColor,
  });

  @override
  CustomColors copyWith({Color? customColor}) {
    return CustomColors(
      cardColor: customColor ?? this.cardColor,
      topBarColor: topBarColor ?? this.topBarColor,
      bgContainerColor: bgContainerColor ?? this.bgContainerColor,
      bgBarColor: bgBarColor ?? this.bgBarColor,
      badgeColor: bgBarColor ?? this.badgeColor,
      titleTextColor: titleTextColor ?? this.titleTextColor,
      bodyTextColor: bodyTextColor ?? this.bodyTextColor,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      cardColor: Color.lerp(cardColor, other.cardColor, t),
      topBarColor: Color.lerp(topBarColor, other.topBarColor, t),
      bgContainerColor: Color.lerp(bgContainerColor, other.bgContainerColor, t),
      bgBarColor: Color.lerp(bgBarColor, other.bgBarColor, t),
      badgeColor: Color.lerp(badgeColor, other.badgeColor, t),
      titleTextColor: Color.lerp(titleTextColor, other.titleTextColor, t),
      bodyTextColor: Color.lerp(bodyTextColor, other.bodyTextColor, t),
    );
  }
}