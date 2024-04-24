// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subtopic.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubtopicAdapter extends TypeAdapter<Subtopic> {
  @override
  final int typeId = 0;

  @override
  Subtopic read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Subtopic(
      subTopicId: fields[0] as String?,
      topicId: fields[1] as String?,
      regionId: fields[3] as String?,
      mainHeading: fields[4] as String?,
      name: fields[5] as String?,
      subtopicHeadline: fields[6] as String?,
      keyword: fields[7] as String?,
      groupkeyword: fields[8] as String?,
      news: fields[9] as String?,
      highlightType: fields[10] as String?,
      highlights: fields[11] as String?,
      description: fields[12] as String?,
      logo: fields[13] as String?,
      newsIcon: fields[14] as String?,
      videoIcon: fields[15] as String?,
      position: fields[16] as int?,
      sequence: fields[17] as int?,
      isMobile: fields[18] as bool?,
      isExternalUrl: fields[19] as bool?,
      externalUrl: fields[20] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Subtopic obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.subTopicId)
      ..writeByte(1)
      ..write(obj.topicId)
      ..writeByte(3)
      ..write(obj.regionId)
      ..writeByte(4)
      ..write(obj.mainHeading)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.subtopicHeadline)
      ..writeByte(7)
      ..write(obj.keyword)
      ..writeByte(8)
      ..write(obj.groupkeyword)
      ..writeByte(9)
      ..write(obj.news)
      ..writeByte(10)
      ..write(obj.highlightType)
      ..writeByte(11)
      ..write(obj.highlights)
      ..writeByte(12)
      ..write(obj.description)
      ..writeByte(13)
      ..write(obj.logo)
      ..writeByte(14)
      ..write(obj.newsIcon)
      ..writeByte(15)
      ..write(obj.videoIcon)
      ..writeByte(16)
      ..write(obj.position)
      ..writeByte(17)
      ..write(obj.sequence)
      ..writeByte(18)
      ..write(obj.isMobile)
      ..writeByte(19)
      ..write(obj.isExternalUrl)
      ..writeByte(20)
      ..write(obj.externalUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubtopicAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
