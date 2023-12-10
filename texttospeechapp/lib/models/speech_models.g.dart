// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speech_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class speechModelAdapter extends TypeAdapter<speechModel> {
  @override
  final int typeId = 0;

  @override
  speechModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return speechModel(
      recognizedSpeeches: fields[0] as String,
      dateAndTime: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, speechModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.recognizedSpeeches)
      ..writeByte(1)
      ..write(obj.dateAndTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is speechModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
