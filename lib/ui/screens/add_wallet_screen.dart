import 'package:flutter/material.dart';
import 'package:wallet/Box/boxWallet.dart';
import 'package:wallet/hive_adapters/WalletAdapter.dart';

class AddWallet extends StatefulWidget {
  const AddWallet({super.key});

  @override
  _AddWalletState createState() => _AddWalletState();
}

class _AddWalletState extends State<AddWallet> {
  final _formKey = GlobalKey<FormState>();
  final _cardNicknameController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _holderNameController = TextEditingController();
  final _expDateController = TextEditingController();
  final _cvvController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    _cardNicknameController.dispose();
    _cardNumberController.dispose();
    _holderNameController.dispose();
    _expDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: const Text('My Form'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _textField('Enter card nickname', _cardNicknameController),
              _textField('Enter card number', _cardNumberController),
              _textField('Enter card holder name', _holderNameController),
              _textField('Enter exp date', _expDateController),
              _textField('Enter cvv', _cvvController),
              const SizedBox(height: 16),
              MaterialButton(
                color: Colors.blue,
                onPressed: () {
                  setState(() {
                    boxWallets.put(
                        'key_$_cardNicknameController',
                        WalletAdapter(
                            _cardNicknameController.text,
                            int.parse(_cardNumberController.text),
                            _holderNameController.text,
                            _expDateController.text,
                            _cvvController.text));
                  Navigator.pop(context);
                  });
                  if (_formKey.currentState!.validate()) {
                    // do something
                  }
                },
                child: Text('Submit', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textField(String hintText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(top:15, left: 10, right: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Invalid Entry';
          }
          return null;
        },
      ),
    );
  }
}
