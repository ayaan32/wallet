import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wallet/Box/boxWallet.dart';
import 'package:wallet/ui/screens/wallet_screen.dart';
import 'package:lottie/lottie.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});
  final String title;

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
      backgroundColor:Colors.grey[100],
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 25),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.grey,
                Colors.blue,
              ],
              stops: [0.3, 1.0],
            ),
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: boxWallets.listenable(),
        builder: (context, Box<dynamic> box, _) {
          return boxWallets.length == 0 ? Center(child: _emptyListWidget()) : ListView.builder(
            itemCount: boxWallets.length,
            itemBuilder: (BuildContext context, int index) {
              final wallet = boxWallets.getAt(index);
              String maskedCardNumber = '**** **** **** ****';
              if (wallet.cardNumber != null && (wallet.cardNumber).toString().length >= 4) {
                String last4 = (wallet.cardNumber.toString()).substring(wallet.cardNumber.toString().length - 4);
                maskedCardNumber = '**** **** **** $last4';
              }
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WalletScreen(index: index),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0.1, 0.4, 0.6, 0.9],
                    colors: [
                      Color(0xffF99D27).withOpacity(0.3),
                      Color(0xffF99D27).withOpacity(0.4),
                      Color(0xff005B75).withOpacity(0.6),
                      Color(0xff005B75).withOpacity(0.9),
                    ],
                  ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 1,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                wallet.cardNickname?.toUpperCase() ?? 'CARD',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Icon(
                                Icons.account_balance_wallet,
                                color: Colors.white,
                                size: 32,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            maskedCardNumber,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              letterSpacing: 2.0,
                              fontFamily: 'Courier', // Monospaced for card number look
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'CARD HOLDER',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    wallet.holderName?.toUpperCase() ?? 'JOHN DOE',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'EXPIRES',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    wallet.expiry ?? 'MM/YY',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
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

  Widget _emptyListWidget() {
  return SingleChildScrollView(
    child: Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'lib/assets/animations/emptyW.gif', // Replace with your GIF file path
              width: 200,
              height: 200,
              fit: BoxFit.contain, // Ensures the GIF fits within the dimensions
            ),
            const SizedBox(height: 10),
            Text(
              'Your wallet is empty.',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontFamily: 'roboto',
                    fontSize: 16,
                  ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                _navigateToAddwalletScreen();
              },
              child: Text(
                'Click on the + button to add a new card!',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontFamily: 'roboto',
                      fontSize: 14,
                      color: Colors.grey,
                    ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}