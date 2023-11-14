import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wallet/Box/boxWallet.dart';
import 'package:wallet/hive_adapters/WalletAdapter.dart';
import 'package:wallet/providers/add_wallet_provider.dart';
import 'package:wallet/ui/screens/add_wallet_screen.dart';
import 'package:wallet/ui/screens/home_page.dart';
import 'package:wallet/ui/screens/wallet_screen.dart';

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(WalletAdapterAdapter());
  boxWallets = await Hive.openBox<WalletAdapter>('walletBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AddWalletProvider())
      ],
      child: MaterialApp(
        routes: {
          '/add_wallet_screen': (context) => const AddWallet(),
          // '/wallet_screen': (context) => WalletScreen(index: index),
    
        },
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Wallet'),
      ),
    );
  }
}

