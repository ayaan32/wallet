import 'package:flutter/material.dart';
import 'package:wallet/Box/boxWallet.dart';
import 'package:wallet/ui/screens/wallet_screen.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void _navigateToAddwalletScreen() {
    setState(() {
      Navigator.pushNamed(context, '/add_wallet_screen');
    });
  }
  // void _navigateToWalletScreen() {
  //   setState(() {
  //     Navigator.pushNamed(context, '/wallet_screen');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Center(child: Text(widget.title, style: const TextStyle(fontSize: 25),)),
      ),
      body: ListView.builder(
  itemCount: boxWallets.length,
  itemBuilder: (BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        WalletScreen(index: index);
        Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => WalletScreen(index: index),
  ),
);
        // print('Card $index tapped.');
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                // color: Colors.grey[400],
                blurRadius: 1,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.account_balance_wallet),
              title: Text(boxWallets.getAt(index).cardNickname),
              // subtitle: Text('Balance: 0.00000000'),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          ),
        ),
      ),
    );
  },
),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddwalletScreen,
        tooltip: 'Add Wallet',
        child: const Icon(Icons.add),
      ),
    );
  }
}