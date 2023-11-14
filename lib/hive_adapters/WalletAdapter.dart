
import 'package:hive/hive.dart';

part 'WalletAdapter.g.dart';

@HiveType(typeId: 1)
class WalletAdapter{
  WalletAdapter(this.cardNickname, this.cardNumber, this.holderName, this.expDate, this.cvv);
  @HiveField(0)
  String cardNickname;
  @HiveField(1)
  int cardNumber;
  @HiveField(2)
  String holderName;
  @HiveField(3)
  String expDate;
  @HiveField(4)
  String cvv;
}