import 'dart:convert';

class ApiMySiteResponse {
  final bool successFlag;
  final int totalCount;
  final List<MySite> data;
  final dynamic miscData;
  final String message;

  ApiMySiteResponse({
    required this.successFlag,
    required this.totalCount,
    required this.data,
    required this.miscData,
    required this.message,
  });

  factory ApiMySiteResponse.fromJson(Map<String, dynamic> json) {
    return ApiMySiteResponse(
      successFlag: json['successFlag'],
      totalCount: json['totalCount'],
      data: List<MySite>.from(json['data'].map((x) => MySite.fromJson(x))),
      miscData: json['miscData'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() => {
        "successFlag": successFlag,
        "totalCount": totalCount,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "miscData": miscData,
        "message": message,
      };
}

class MySite {
  final String id;
  final String regionId;
  final String? mainHeading;
  final String topicId;
  final String subTopicId;
  final String iconImage;
  final String url;
  final String description;
  final DateTime? datetime;
  final bool isActive;
  final DateTime createdOn;
  final String createdBy;
  final DateTime? editOn;
  final String? editBy;

  MySite({
    required this.id,
    required this.regionId,
    this.mainHeading,
    required this.topicId,
    required this.subTopicId,
    required this.iconImage,
    required this.url,
    required this.description,
    this.datetime,
    required this.isActive,
    required this.createdOn,
    required this.createdBy,
    this.editOn,
    this.editBy,
  });

  factory MySite.fromRawJson(String str) => MySite.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MySite.fromJson(Map<String, dynamic> json) => MySite(
        id: json['id'],
        regionId: json['regionId'],
        mainHeading: json['mainHeading'],
        topicId: json['topicId'],
        subTopicId: json['subTopicId'],
        iconImage: json['iconImage'],
        url: json['url'],
        description: json['description'],
        datetime: json['datetime'] == null ? null : DateTime.parse(json['datetime']),
        isActive: json['isActive'],
        createdOn: DateTime.parse(json['createdOn']),
        createdBy: json['createdBy'],
        editOn: json['editOn'] == null ? null : DateTime.parse(json['editOn']),
        editBy: json['editBy'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'regionId': regionId,
        'mainHeading': mainHeading,
        'topicId': topicId,
        'subTopicId': subTopicId,
        'iconImage': iconImage,
        'url': url,
        'description': description,
        'datetime': datetime?.toIso8601String(),
        'isActive': isActive,
        'createdOn': createdOn.toIso8601String(),
        'createdBy': createdBy,
        'editOn': editOn?.toIso8601String(),
        'editBy': editBy,
      };
}
