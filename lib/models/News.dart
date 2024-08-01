import 'dart:convert';

class ApiNewsResponse {
  final List<News> news;

  ApiNewsResponse({
    required this.news,
  });

  factory ApiNewsResponse.fromJson(List<dynamic> json) {
    return ApiNewsResponse(
      news: json.map((e) => News.fromJson(e)).toList(),
    );
  }

  List<News> getNews() {
    return news;
  }
}

class News {
  final String? id;
  final String? title;
  final String? titleEng;
  final String? abstractEng;
  final String? contributorName;
  final String? contributorRole;
  final String? contentEng;
  final List<Media>? medias;
  final String? abstract;
  final String? content;
  final bool? isExternal;
  final String? articleLink;
  final String? articleDetailLink;
  final String? creator;
  final String? creatorImg;
  final String? type;
  final String? iconSource;
  final bool? isPublished;
  final String? generalistName;
  final String? generalistRole;
  final String? generalistProfile;
  final DateTime? published;

  News({
    this.id,
    this.title,
    this.titleEng,
    this.abstractEng,
    this.contributorName,
    this.contributorRole,
    this.contentEng,
    this.medias,
    this.abstract,
    this.content,
    this.isExternal,
    this.articleLink,
    this.articleDetailLink,
    this.creator,
    this.creatorImg,
    this.type,
    this.iconSource,
    this.isPublished,
    this.generalistName,
    this.generalistRole,
    this.generalistProfile,
    this.published,
  });

  News copyWith({
    String? id,
    String? title,
    String? titleEng,
    String? abstractEng,
    String? contributorName,
    String? contributorRole,
    String? contentEng,
    List<Media>? medias,
    String? abstract,
    String? content,
    bool? isExternal,
    String? articleLink,
    String? articleDetailLink,
    String? creator,
    String? creatorImg,
    String? type,
    String? iconSource,
    bool? isPublished,
    String? generalistName,
    String? generalistRole,
    String? generalistProfile,
    DateTime? published,
  }) =>
      News(
        id: id ?? this.id,
        title: title ?? this.title,
        titleEng: titleEng ?? this.titleEng,
        abstractEng: abstractEng ?? this.abstractEng,
        contributorName: contributorName ?? this.contributorName,
        contributorRole: contributorRole ?? this.contributorRole,
        contentEng: contentEng ?? this.contentEng,
        medias: medias ?? this.medias,
        abstract: abstract ?? this.abstract,
        content: content ?? this.content,
        isExternal: isExternal ?? this.isExternal,
        articleLink: articleLink ?? this.articleLink,
        articleDetailLink: articleDetailLink ?? this.articleDetailLink,
        creator: creator ?? this.creator,
        creatorImg: creatorImg ?? this.creatorImg,
        type: type ?? this.type,
        iconSource: iconSource ?? this.iconSource,
        isPublished: isPublished ?? this.isPublished,
        generalistName: generalistName ?? this.generalistName,
        generalistRole: generalistRole ?? this.generalistRole,
        generalistProfile: generalistProfile ?? this.generalistProfile,
        published: published ?? this.published,
      );

  factory News.fromRawJson(String str) => News.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory News.fromJson(Map<String, dynamic> json) => News(
        id: json["_id"],
        title: json["_title"],
        titleEng: json["_titleEng"],
        abstractEng: json["_abstractEng"],
        contributorName: json["_contributorName"],
        contributorRole: json["_contributorRole"],
        contentEng: json["_contentEng"],
        medias: json["_medias"] == null
            ? []
            : List<Media>.from(json["_medias"].map((x) => Media.fromJson(x))),
        abstract: json["_abstract"],
        content: json["_content"],
        isExternal: json["_isExternal"],
        articleLink: json["_ArticleLink"],
        articleDetailLink: json["_ArticleDetailLink"],
        creator: json["_Creator"],
        creatorImg: json["_CreatorImg"],
        type: json["_Type"],
        iconSource: json["_IconSource"],
        isPublished: json["_IsPublished"],
        generalistName: json["_GeneralistName"],
        generalistRole: json["_GeneralistRole"],
        generalistProfile: json["_GeneralistProfile"],
        published: json["_published"] == null
            ? null
            : DateTime.parse(json["_published"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "_title": title,
        "_titleEng": titleEng,
        "_abstractEng": abstractEng,
        "_contributorName": contributorName,
        "_contributorRole": contributorRole,
        "_contentEng": contentEng,
        "_medias": medias == null
            ? []
            : List<dynamic>.from(medias!.map((x) => x.toJson())),
        "_abstract": abstract,
        "_content": content,
        "_isExternal": isExternal,
        "_ArticleLink": articleLink,
        "_ArticleDetailLink": articleDetailLink,
        "_Creator": creator,
        "_CreatorImg": creatorImg,
        "_Type": type,
        "_IconSource": iconSource,
        "_IsPublished": isPublished,
        "_GeneralistName": generalistName,
        "_GeneralistRole": generalistRole,
        "_GeneralistProfile": generalistProfile,
        "_published": published?.toIso8601String(),
      };
}

class Media {
  final String? role;
  final int? sizeInBytes;
  final String? rendition;
  final int? width;
  final String? href;
  final String? type;
  final int? height;

  Media({
    this.role,
    this.sizeInBytes,
    this.rendition,
    this.width,
    this.href,
    this.type,
    this.height,
  });

  Media copyWith({
    String? role,
    int? sizeInBytes,
    String? rendition,
    int? width,
    String? href,
    String? type,
    int? height,
  }) =>
      Media(
        role: role ?? this.role,
        sizeInBytes: sizeInBytes ?? this.sizeInBytes,
        rendition: rendition ?? this.rendition,
        width: width ?? this.width,
        href: href ?? this.href,
        type: type ?? this.type,
        height: height ?? this.height,
      );

  factory Media.fromRawJson(String str) => Media.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        role: json["role"],
        sizeInBytes: json["sizeInBytes"],
        rendition: json["rendition"],
        width: json["width"],
        href: json["href"],
        type: json["type"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "role": role,
        "sizeInBytes": sizeInBytes,
        "rendition": rendition,
        "width": width,
        "href": href,
        "type": type,
        "height": height,
      };
}
