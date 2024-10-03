// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clothes.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClothesAdapter extends TypeAdapter<Clothes> {
  @override
  final int typeId = 1;

  @override
  Clothes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Clothes(
      clothesId: fields[0] as String,
      name: fields[1] as String,
      price: fields[2] as String,
      imagePaths: (fields[3] as List).cast<String>(),
      description: fields[4] as String,
      size: (fields[5] as List).cast<String>(),
      characteristics: (fields[6] as Map).cast<String, String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Clothes obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.clothesId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.imagePaths)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.size)
      ..writeByte(6)
      ..write(obj.characteristics);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClothesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
