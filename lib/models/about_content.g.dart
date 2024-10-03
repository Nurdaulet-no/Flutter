// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'about_content.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AboutContentAdapter extends TypeAdapter<AboutContent> {
  @override
  final int typeId = 3;

  @override
  AboutContent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AboutContent()..textContent = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, AboutContent obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.textContent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AboutContentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
