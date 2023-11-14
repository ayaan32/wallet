
import 'package:flutter/material.dart';

class AddWalletProvider extends ChangeNotifier {
  String cardNickname;
  String cardNumber;
  String holderName;
  String expDate;
  String cvv;

  AddWalletProvider({
    this.cardNickname = 'Demo Card Nickname',
    this.cardNumber = 'Demo Card Number',
    this.holderName = 'Demo Holder Name',
    this.expDate = 'Demo Exp Date',
    this.cvv = 'Demo CVV',
  });

  void updateCardNickname(String newCardNickname) async{
    cardNickname = newCardNickname;
    notifyListeners();
  }

  void updateCardNumber(String newCardNumber) async{
    cardNumber = newCardNumber;
    notifyListeners();
  }

  void updateHolderName(String newHolderName) async{
    holderName = newHolderName;
    notifyListeners();
  }

  void updateExpDate(String newExpDate) async{
    expDate = newExpDate;
    notifyListeners();
  }

  void updateCvv(String newCvv) async{
    cvv = newCvv;
    notifyListeners();
  }

}
