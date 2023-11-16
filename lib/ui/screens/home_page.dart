import 'package:flutter/material.dart';
import 'package:wallet/Box/boxWallet.dart';
import 'package:wallet/ui/screens/wallet_screen.dart';

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
        title: Center(
            child: Text(
          widget.title,
          style: const TextStyle(fontSize: 25),
        )),
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
      body: boxWallets.length == 0 ? Center(child: _neumorphicCard()) : ListView.builder(
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
                    title: Text(
                      boxWallets.getAt(index).cardNickname.toUpperCase(),
                      style: const TextStyle(fontSize: 18),
                    ),
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

  Widget _cardWidget(){
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width * 0.9, 
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [
                0.1,
                0.4,
                0.6,
                0.9,
              ],
              colors: [
                Color(0xffF99D27).withOpacity(0.3),
                Color(0xffF99D27).withOpacity(0.4),
                Color(0xff005B75).withOpacity(0.6),
                Color(0xff005B75).withOpacity(0.9),
              ],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              'Hello Gradient!',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
      ),
    );
  }


  // Widget _neumorphicCard() {
  //   return Neumorphic(
  //     style: NeumorphicStyle(
  //       shape: NeumorphicShape.concave,
  //       boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
  //       depth: 8,
  //       lightSource: LightSource.topLeft,
  //       color: Colors.grey[300],
  //     ),
  //     child: Container(
  //       height: 200,
  //       width: MediaQuery.of(context).size.width * 0.7,
  //       alignment: Alignment.center,
  //       child: Text('Neumorphic Card'),
  //     ),
  //   );
  // }

  Widget _neumorphicCard() {
   return Container(
  width: MediaQuery.of(context).size.width * 0.9,
  height: 200,
  decoration: BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: Colors.white.withOpacity(0.8),
        offset: Offset(-6.0, -6.0),
        blurRadius: 16.0,
      ),
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        offset: Offset(6.0, 6.0),
        blurRadius: 16.0,
      ),
    ],
    color: Color(0xFFEFEEEE),
    borderRadius: BorderRadius.circular(12.0),
  ),
);
  }
  
  Widget _emptyListWidget(){
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('lib/assets/images/empty_wallet.png', width: 200, height: 200),
            SizedBox(height: 10,),
            Text('Your wallet is empty.', style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontFamily: 'roboto', fontSize: 16),),
            SizedBox(height: 10,),
            Text('Click on the + button to add a new card!', style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontFamily: 'roboto', fontSize: 14, color: Colors.grey),)
          ],
        ),
      ),
    );
  }
}
