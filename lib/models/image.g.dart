// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyImageAdapter extends TypeAdapter<MyImage> {
  @override
  final int typeId = 0;

  @override
  MyImage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyImage(
      fields[0] as int,
      fields[1] as String,
      (fields[2] as List).cast<Sticker>(),
    );
  }

  @override
  void write(BinaryWriter writer, MyImage obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.path)
      ..writeByte(2)
      ..write(obj.stickers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyImageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
