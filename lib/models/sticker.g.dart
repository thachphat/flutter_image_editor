// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sticker.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StickerAdapter extends TypeAdapter<Sticker> {
  @override
  final int typeId = 1;

  @override
  Sticker read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Sticker(
      fields[0] as String,
      fields[1] as double,
      fields[2] as double,
      fields[3] as double,
      fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Sticker obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.scale)
      ..writeByte(2)
      ..write(obj.angle)
      ..writeByte(3)
      ..write(obj.dx)
      ..writeByte(4)
      ..write(obj.dy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StickerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
