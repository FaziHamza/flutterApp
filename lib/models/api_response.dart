import 'dart:convert';

import 'package:news/models/subtopic.dart';

class ApiResponse {
  final String? name;
  final String? apiResponseDefault;
  final String? api;
  final List<MenuItem>? menuItems;

  ApiResponse({
    this.name,
    this.apiResponseDefault,
    this.api,
    this.menuItems,
  });

  ApiResponse copyWith({
    String? name,
    String? apiResponseDefault,
    String? api,
    List<MenuItem>? menuItems,
  }) =>
      ApiResponse(
        name: name ?? this.name,
        apiResponseDefault: apiResponseDefault ?? this.apiResponseDefault,
        api: api ?? this.api,
        menuItems: menuItems ?? this.menuItems,
      );

  factory ApiResponse.fromRawJson(String str) =>
      ApiResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        name: json["name"],
        apiResponseDefault: json["default"],
        api: json["api"],
        menuItems: json["menuItems"] == null
            ? []
            : List<MenuItem>.from(
                json["menuItems"]!.map((x) => MenuItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "default": apiResponseDefault,
        "api": api,
        "menuItems": menuItems == null
            ? []
            : List<dynamic>.from(menuItems!.map((x) => x.toJson())),
      };
}

class MenuItem {
  final String? id;
  final String? name;
  final String? iconSource;
  final String? actionBar;
  final List<Topic>? topics;

  MenuItem({
    this.id,
    this.name,
    this.iconSource,
    this.actionBar,
    this.topics,
  });

  MenuItem copyWith({
    String? id,
    String? name,
    String? iconSource,
    String? actionBar,
    List<Topic>? topics,
  }) =>
      MenuItem(
        id: id ?? this.id,
        name: name ?? this.name,
        iconSource: iconSource ?? this.iconSource,
        actionBar: actionBar ?? this.actionBar,
        topics: topics ?? this.topics,
      );

  factory MenuItem.fromRawJson(String str) =>
      MenuItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
        id: json["id"],
        name: json["name"],
        iconSource: json["iconSource"],
        actionBar: json["actionBar"],
        topics: json["topics"] == null
            ? []
            : List<Topic>.from(json["topics"]!.map((x) => Topic.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "iconSource": iconSource,
        "actionBar": actionBar,
        "topics": topics == null
            ? []
            : List<dynamic>.from(topics!.map((x) => x.toJson())),
      };
}

class Topic {
  final String? topicId;
  final String? regionId;
  final String? mainHeading;
  final String? mainHeadingLogo;
  final String? name;
  final String? actionBar;
  final String? highlights;
  final String? highlights2;
  final String? logo;
  final String? description;
  final String? navLogo;
  final String? menuFlag;
  final int? position;
  final int? sequence;
  final bool? isActive;
  final List<Subtopic>? subtopics;

  Topic({
    this.topicId,
    this.regionId,
    this.mainHeading,
    this.mainHeadingLogo,
    this.name,
    this.actionBar,
    this.highlights,
    this.highlights2,
    this.logo,
    this.description,
    this.navLogo,
    this.menuFlag,
    this.position,
    this.sequence,
    this.isActive,
    this.subtopics,
  });

  Topic copyWith({
    String? topicId,
    String? regionId,
    String? mainHeading,
    String? mainHeadingLogo,
    String? name,
    String? actionBar,
    String? highlights,
    String? highlights2,
    String? logo,
    String? description,
    String? navLogo,
    String? menuFlag,
    int? position,
    int? sequence,
    bool? isActive,
    List<Subtopic>? subtopics,
  }) =>
      Topic(
        topicId: topicId ?? this.topicId,
        regionId: regionId ?? this.regionId,
        mainHeading: mainHeading ?? this.mainHeading,
        mainHeadingLogo: mainHeadingLogo ?? this.mainHeadingLogo,
        name: name ?? this.name,
        actionBar: actionBar ?? this.actionBar,
        highlights: highlights ?? this.highlights,
        highlights2: highlights2 ?? this.highlights2,
        logo: logo ?? this.logo,
        description: description ?? this.description,
        navLogo: navLogo ?? this.navLogo,
        menuFlag: menuFlag ?? this.menuFlag,
        position: position ?? this.position,
        sequence: sequence ?? this.sequence,
        isActive: isActive ?? this.isActive,
        subtopics: subtopics ?? this.subtopics,
      );

  factory Topic.fromRawJson(String str) => Topic.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        topicId: json["topicID"],
        regionId: json["regionId"],
        mainHeading: json["mainHeading"],
        mainHeadingLogo: json["mainHeadingLogo"],
        name: json["name"],
        actionBar: json["actionBar"],
        highlights: json["highlights"],
        highlights2: json["highlights2"],
        logo: json["logo"],
        description: json["description"],
        navLogo: json["navLogo"],
        menuFlag: json["menuFlag"],
        position: json["position"],
        sequence: json["sequence"],
        isActive: json["isActive"],
        subtopics: json["subtopics"] == null
            ? []
            : List<Subtopic>.from(
                json["subtopics"]!.map((x) => Subtopic.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "topicID": topicId,
        "regionId": regionId,
        "mainHeading": mainHeading,
        "mainHeadingLogo": mainHeadingLogo,
        "name": name,
        "actionBar": actionBar,
        "highlights": highlights,
        "highlights2": highlights2,
        "logo": logo,
        "description": description,
        "navLogo": navLogo,
        "menuFlag": menuFlag,
        "position": position,
        "sequence": sequence,
        "isActive": isActive,
        "subtopics": subtopics == null
            ? []
            : List<dynamic>.from(subtopics!.map((x) => x.toJson())),
      };
}
