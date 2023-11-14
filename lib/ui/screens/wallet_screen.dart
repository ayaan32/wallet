import 'package:flutter/material.dart';
import 'package:wallet/Box/boxWallet.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(boxWallets.getAt(index).cardNickname),
            Text(boxWallets.getAt(index).cardNumber.toString()),
            Text(boxWallets.getAt(index).holderName),
            Text(boxWallets.getAt(index).expDate),
            Text(boxWallets.getAt(index).cvv),
          ],
        ),
      ),
    );
  }

  Widget _textWidget(String data) {
    return Text(data);
  }
}