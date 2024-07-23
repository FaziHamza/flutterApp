import 'dart:convert';

class ApiHighlightsResponse {
  final List<HighLights> data;


  ApiHighlightsResponse({
    required this.data,
  });

  factory ApiHighlightsResponse.fromJson(Map<String, dynamic> json) {
    return ApiHighlightsResponse(
      data: List<HighLights>.from(json['response'].map((x) => HighLights.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "response": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class HighLights{
  final String title;
  final String competition;
  final String matchviewUrl;
  final String competitionUrl;
  final String thumbnail;
  final DateTime date;
  final List<Video> videos;

  HighLights({
    required this.title,
    required this.competition,
    required this.matchviewUrl,
    required this.competitionUrl,
    required this.thumbnail,
    required this.date,
    required this.videos,
  });

  factory HighLights.fromRawJson(String str) => HighLights.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HighLights.fromJson(Map<String, dynamic> json) => HighLights(
        title: json['title'],
        competition: json['competition'],
        matchviewUrl: json['matchviewUrl'],
        competitionUrl: json['competitionUrl'],
        thumbnail: json['thumbnail'],
        date: DateTime.parse(json['date']),
        videos: List<Video>.from(json['videos'].map((x) => Video.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'competition': competition,
        'matchviewUrl': matchviewUrl,
        'competitionUrl': competitionUrl,
        'thumbnail': thumbnail,
        'date': date.toIso8601String(),
        'videos': List<dynamic>.from(videos.map((x) => x.toJson())),
      };
}

class Video {
  final String id;
  final String title;
  final String embed;

  Video({
    required this.id,
    required this.title,
    required this.embed,
  });

  factory Video.fromRawJson(String str) => Video.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json['id'],
        title: json['title'],
        embed: json['embed'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'embed': embed,
      };
}
