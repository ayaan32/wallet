import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:wallet/Box/boxWallet.dart';
import 'package:wallet/hive_adapters/WalletAdapter.dart';

class ExpiryFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.replaceAll('/', '');
    if (text.length > 2) {
      text = '${text.substring(0, 2)}/${text.substring(2)}';
    }
    if (text.length > 5) {
      text = text.substring(0, 5);
    }
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class ModifyWalletScreen extends StatefulWidget {
  const ModifyWalletScreen({super.key, required this.index});
  final int index;

  @override
  _ModifyWalletScreenState createState() => _ModifyWalletScreenState();
}

class _ModifyWalletScreenState extends State<ModifyWalletScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _cardNicknameController;
  late TextEditingController _cardNumberController;
  late TextEditingController _holderNameController;
  late TextEditingController _expDateController;
  late TextEditingController _cvvController;

  final FocusNode _nicknameFocus = FocusNode();
  final FocusNode _cardNumberFocus = FocusNode();
  final FocusNode _holderNameFocus = FocusNode();
  final FocusNode _expDateFocus = FocusNode();
  final FocusNode _cvvFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    // Retrieve the wallet data from Hive using the index
    final wallet = boxWallets.getAt(widget.index);
    // Initialize controllers with existing wallet data
    _cardNicknameController = TextEditingController(text: wallet.cardNickname);
    _cardNumberController = TextEditingController(text: wallet.cardNumber.toString());
    _holderNameController = TextEditingController(text: wallet.holderName);
    _expDateController = TextEditingController(text: wallet.expiry);
    _cvvController = TextEditingController(text: wallet.cvv);
  }

  @override
  void dispose() {
    _cardNicknameController.dispose();
    _cardNumberController.dispose();
    _holderNameController.dispose();
    _expDateController.dispose();
    _cvvController.dispose();
    _nicknameFocus.dispose();
    _cardNumberFocus.dispose();
    _holderNameFocus.dispose();
    _expDateFocus.dispose();
    _cvvFocus.dispose();
    super.dispose();
  }

  KeyboardActionsConfig _buildKeyboardActionsConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.white,
      nextFocus: true,
      actions: [
        KeyboardActionsItem(focusNode: _nicknameFocus),
        KeyboardActionsItem(focusNode: _cardNumberFocus),
        KeyboardActionsItem(focusNode: _holderNameFocus),
        KeyboardActionsItem(focusNode: _expDateFocus),
        KeyboardActionsItem(
          focusNode: _cvvFocus,
          toolbarButtons: [
            (node) => GestureDetector(
              onTap: () {
                node.unfocus();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Done"),
              ),
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey, Colors.blue],
              stops: [0.3, 1.0],
            ),
          ),
        ),
        title: const Text('Edit Card'),
      ),
      body: Form(
        key: _formKey,
        child: KeyboardActions(
          config: _buildKeyboardActionsConfig(context),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _textField('Enter card nickname', _cardNicknameController, maxLength: 20, focusNode: _nicknameFocus),
                _textField('Enter card number', _cardNumberController,
                    isNumeric: true, exactLength: 16, maxLength: 16,
                    formatters: [FilteringTextInputFormatter.digitsOnly], focusNode: _cardNumberFocus),
                _textField('Enter card holder name', _holderNameController, focusNode: _holderNameFocus),
                _textField('Enter exp date', _expDateController,
                    formatters: [ExpiryFormatter(), FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')), LengthLimitingTextInputFormatter(5)], 
                    useNumericKeyboard: true, focusNode: _expDateFocus),
                _textField('Enter cvv', _cvvController, isNumeric: true, exactLength: 3, maxLength: 3, focusNode: _cvvFocus),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
                  child: MaterialButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80),
                    ),
                    minWidth: double.infinity,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          // Update the existing wallet entry in Hive
                          boxWallets.putAt(
                            widget.index,
                            WalletAdapter(
                              _cardNicknameController.text,
                              int.parse(_cardNumberController.text),
                              _holderNameController.text,
                              _expDateController.text,
                              _cvvController.text,
                            ),
                          );
                          Navigator.pop(context);
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: Text('Update', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textField(String hintText, TextEditingController controller,
      {int? maxLength, bool isNumeric = false, int? exactLength, List<TextInputFormatter>? formatters, FocusNode? focusNode, bool useNumericKeyboard = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
        maxLength: maxLength,
        keyboardType: useNumericKeyboard || isNumeric ? TextInputType.number : TextInputType.text,
        inputFormatters: formatters,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $hintText';
          }
          if (maxLength != null && value.length > maxLength) {
            return 'Must not exceed $maxLength characters';
          }
          if (isNumeric) {
            if (!RegExp(r'^\d+$').hasMatch(value)) {
              return '$hintText must be a number';
            }
            if (exactLength != null && value.length != exactLength) {
              return '$hintText must be exactly $exactLength digits';
            }
          }
          if (hintText == 'Enter exp date' && value.isNotEmpty) {
            if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(value)) {
              return 'Enter date as MM/YY (e.g., 12/25)';
            }
          }
          return null;
        },
      ),
    );
  }
}