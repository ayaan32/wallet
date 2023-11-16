import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet/Box/boxWallet.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          boxWallets.getAt(index).cardNickname.toUpperCase(),
          style: const TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Handle edit action
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Handle delete action
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirm Delete'),
                    content: const Text(
                        'Are you sure you want to delete this card?'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Delete'),
                        onPressed: () {
                          // Handle delete action
                          Navigator.of(context).pop();
                          boxWallets.deleteAt(index);
                        },
                      ),
                    ],
                  );
                },
              );
                          // Navigator.of(context).pop();

            },
          ),
        ],
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
      body: Center(
        child: Column(
          children: <Widget>[
            _fieldWidget(
                'Card Number',
                _textWidget(
                    boxWallets.getAt(index).cardNumber.toString(), context),
                boxWallets.getAt(index).cardNumber.toString(),
                context),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            _fieldWidget(
                "Holder's Name",
                _textWidget(boxWallets.getAt(index).holderName, context),
                boxWallets.getAt(index).holderName,
                context),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            _fieldWidget(
                'Exp Date',
                _textWidget(boxWallets.getAt(index).expDate, context),
                boxWallets.getAt(index).expDate,
                context),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            _fieldWidget(
                'CVV',
                _textWidget(boxWallets.getAt(index).cvv, context),
                boxWallets.getAt(index).cvv,
                context),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _textWidget(String data, BuildContext context) {
    double? fontsize;
    FontWeight? fontweight;
    Color? color;
    if (data.isNotEmpty) {
      fontsize = 20;
      fontweight = FontWeight.w400;
      color = Colors.black;
    } else {
      fontsize = 12;
      fontweight = FontWeight.w400;
      color = Colors.grey;
    }
    return Text(data.isNotEmpty ? data : 'You chose not to save this field.',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: fontsize,
            fontFamily: 'roboto',
            fontWeight: fontweight,
            color: color));
  }

  Widget _fieldWidget(
      String header, Widget body, String data, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: Container(
        // height: 80,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: const BoxDecoration(
            // border: Border.all(),
            // borderRadius: BorderRadius.circular(8),
            // bordercolor: Colors.blue[100],
            // color: Colors.blue[100],
            ),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Expanded(
              flex: 3,
              child: Text(
                header,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                    fontFamily: 'roboto',
                    fontWeight: FontWeight.w500),
              )),
          Expanded(flex: 4, child: body),
          GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: data.toString()));
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Copied to Clipboard'),
                  duration: Duration(seconds: 1),
                ));
              },
              child: const Icon(
                Icons.copy,
                color: Colors.grey,
                size: 15,
              ))
        ]),
      ),
    );
  }
}
