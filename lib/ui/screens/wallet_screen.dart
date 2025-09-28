import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet/Box/boxWallet.dart';
import 'package:wallet/ui/screens/modify_wallet_screen.dart'; // Add this import

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    final wallet = boxWallets.getAt(index);
    String maskedCardNumber = '**** **** **** ****';
    if (wallet.cardNumber != null && wallet.cardNumber.toString().length >= 4) {
      String last4 = wallet.cardNumber.toString().substring(wallet.cardNumber.toString().length - 4);
      maskedCardNumber = '**** **** **** $last4';
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          wallet.cardNickname.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.grey,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ModifyWalletScreen(index: index),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    title: const Text('Confirm Delete'),
                    content: const Text('Are you sure you want to delete this card?'),
                    actions: [
                      TextButton(
                        child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      TextButton(
                        child: const Text('Delete', style: TextStyle(color: Colors.red)),
                        onPressed: () {
                          boxWallets.deleteAt(index);
                          Navigator.of(context).pop(); // Close dialog
                          Navigator.of(context).pop(); // Return to home page
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 24),
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
                      blurRadius: 10,
                      offset: const Offset(0, 4),
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
                            wallet.cardNickname.toUpperCase(),
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
                      Text(
                        wallet.cardNumber != null
                            ? wallet.cardNumber.toString().replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} ")
                            : '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          letterSpacing: 2.0,
                          fontFamily: 'Courier',
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'CARD HOLDER',
                                style: TextStyle(color: Colors.white70, fontSize: 12),
                              ),
                              Text(
                                wallet.holderName?.toUpperCase() ?? 'JOHN DOE',
                                style: const TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'EXPIRES',
                                style: TextStyle(color: Colors.white70, fontSize: 12),
                              ),
                              Text(
                                wallet.expiry ?? 'MM/YY',
                                style: const TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.8),
                      offset: const Offset(-6.0, -6.0),
                      blurRadius: 16.0,
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(6.0, 6.0),
                      blurRadius: 16.0,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _fieldWidget(
                      'Card Number',
                      wallet.cardNumber.toString(),
                      wallet.cardNumber.toString(),
                      context,
                    ),
                    const Divider(height: 24, thickness: 1, color: Colors.grey),
                    _fieldWidget(
                      'Card Holder',
                      wallet.holderName.toUpperCase() ?? 'Not provided',
                      wallet.holderName.toUpperCase() ?? 'Not provided',
                      context,
                    ),
                    const Divider(height: 24, thickness: 1, color: Colors.grey),
                    _fieldWidget(
                      'Expiry Date',
                      wallet.expiry ?? 'Not provided',
                      wallet.expiry ?? 'Not provided',
                      context,
                    ),
                    const Divider(height: 24, thickness: 1, color: Colors.grey),
                    _fieldWidget(
                      'CVV',
                      wallet.cvv ?? 'Not provided',
                      wallet.cvv ?? 'Not provided',
                      context,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fieldWidget(String header, String data, String copyData, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            header,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            data.isNotEmpty ? data : 'Not provided',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: data.isNotEmpty ? 18 : 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  color: data.isNotEmpty ? Colors.black87 : Colors.grey,
                ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Clipboard.setData(ClipboardData(text: copyData));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Copied to Clipboard'),
                duration: const Duration(seconds: 1),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                backgroundColor: Colors.blue.withOpacity(0.9),
              ),
            );
          },
          child: Icon(
            Icons.copy,
            color: Colors.grey[600],
            size: 20,
          ),
        ),
      ],
    );
  }
}