// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package:softbol/models/player.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayerAdapter extends TypeAdapter<Player> {
  @override
  final int typeId = 0;

  @override
  Player read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Player(
      id: fields[0] as int?,
      name: fields[1] as String,
      number: fields[2] as int,
      hits: fields[3] as int,
      atBats: fields[4] as int,
      homeRuns: fields[5] as int,
      RBIs: fields[6] as int,
      stolenBases: fields[7] as int,
      baseonballs: fields[8] as int,
      ponches: fields[9] as int,
      anotadas: fields[10] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Player obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.number)
      ..writeByte(3)
      ..write(obj.hits)
      ..writeByte(4)
      ..write(obj.atBats)
      ..writeByte(5)
      ..write(obj.homeRuns)
      ..writeByte(6)
      ..write(obj.RBIs)
      ..writeByte(7)
      ..write(obj.stolenBases)
      ..writeByte(8)
      ..write(obj.baseonballs)
      ..writeByte(9)
      ..write(obj.ponches)
      ..writeByte(10)
      ..write(obj.anotadas);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
