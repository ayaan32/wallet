// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WalletAdapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WalletAdapterAdapter extends TypeAdapter<WalletAdapter> {
  @override
  final int typeId = 1;

  @override
  WalletAdapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WalletAdapter(
      fields[0] as String,
      fields[1] as int,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WalletAdapter obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.cardNickname)
      ..writeByte(1)
      ..write(obj.cardNumber)
      ..writeByte(2)
      ..write(obj.holderName)
      ..writeByte(3)
      ..write(obj.expDate)
      ..writeByte(4)
      ..write(obj.cvv);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletAdapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
