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


          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Row(
          //       children: [
          //         SizedBox(
          //           width: AppWidgetSize.dimen_12,
          //         ),
          //         Text(localizationTexts.order,
          //             style: Theme.of(context).textTheme.bodySmall!.copyWith(
          //                 color: AppUtils().isLightTheme()
          //                     ? AppColors.radioHeadingColor
          //                     : Colors.white,
          //                 fontWeight: FontWeight.w400,
          //                 fontSize: 16,
          //                 fontFamily: 'rubik')),
          //         SizedBox(
          //           width: AppWidgetSize.dimen_7,
          //         ),
          //         Icon(Icons.info_outline_rounded,
          //             color: AppUtils().isLightTheme()
          //                 ? Colors.black.withOpacity(0.4)
          //                 : Colors.white.withOpacity(0.4),
          //             size: AppWidgetSize.dimen_15),
          //       ],
          //     ),
          //     GestureDetector(
          //       onTap: () {
          //         showModalBottomSheet(
          //             context: context,
          //             builder: (BuildContext context) {
          //               return Container(
          //                 height: 220,
          //                 child: Column(
          //                   children: [
          //                     Column(
          //                       children: [
          //                         const SizedBox(
          //                           height: 10,
          //                         ),
          //                         Text(
          //                           localizationTexts.marketDepth,
          //                           style: Theme.of(context)
          //                               .textTheme
          //                               .headlineLarge!
          //                               .copyWith(fontSize: 24),
          //                         ),
          //                         const Padding(
          //                           padding: EdgeInsets.only(
          //                               left: 12, right: 12, bottom: 0),
          //                           child: Divider(
          //                               color: Color(0xffD5DFEA), thickness: 1),
          //                         ),
          //                         Row(
          //                           mainAxisAlignment:
          //                               MainAxisAlignment.spaceAround,
          //                           children: [
          //                             MarketDepthExpandedContentWidget(
          //                                 header: localizationTexts.qty,
          //                                 data: const [251, 82, 663],
          //                                 dataListColor: AppUtils()
          //                                         .isLightTheme()
          //                                     ? const Color(0xFF002953)
          //                                         .withOpacity(0.7)
          //                                     : Colors.white.withOpacity(0.8)),
          //                             MarketDepthExpandedContentWidget(
          //                                 header: localizationTexts.ord,
          //                                 data: const [251, 82, 663],
          //                                 dataListColor: AppUtils()
          //                                         .isLightTheme()
          //                                     ? const Color(0xFF002953)
          //                                         .withOpacity(0.7)
          //                                     : Colors.white.withOpacity(0.8)),
          //                             MarketDepthExpandedContentWidget(
          //                                 header: localizationTexts.bidPrice,
          //                                 data: const [251, 82, 663],
          //                                 dataListColor: const Color(0xFF06A578)
          //                                     .withOpacity(0.7)),
          //                             MarketDepthExpandedContentWidget(
          //                                 header: localizationTexts.offerPrice,
          //                                 data: const [251, 82, 663],
          //                                 dataListColor: const Color(0xFFFF6161)
          //                                     .withOpacity(0.7)),
          //                             MarketDepthExpandedContentWidget(
          //                                 header: localizationTexts.ord,
          //                                 data: const [251, 82, 663],
          //                                 dataListColor: AppUtils()
          //                                         .isLightTheme()
          //                                     ? const Color(0xFF002953)
          //                                         .withOpacity(0.7)
          //                                     : Colors.white.withOpacity(0.8)),
          //                             MarketDepthExpandedContentWidget(
          //                                 header: localizationTexts.qty,
          //                                 data: const [251, 82, 663],
          //                                 dataListColor: AppUtils()
          //                                         .isLightTheme()
          //                                     ? const Color(0xFF002953)
          //                                         .withOpacity(0.7)
          //                                     : Colors.white.withOpacity(0.8)),
          //                           ],
          //                         ),
          //                         const Padding(
          //                           padding: EdgeInsets.only(
          //                               left: 12, right: 12, bottom: 5),
          //                           child: Divider(
          //                               color: Color(0xffD5DFEA), thickness: 1),
          //                         ),
          //                       ],
          //                     ),
          //                     Row(
          //                       mainAxisAlignment:
          //                           MainAxisAlignment.spaceAround,
          //                       children: [
          //                         Container(
          //                           width:
          //                               MediaQuery.of(context).size.width * 0.4,
          //                           child: Row(
          //                             mainAxisAlignment:
          //                                 MainAxisAlignment.spaceBetween,
          //                             children: [
          //                               Text(
          //                                 '4,74,404',
          //                                 style: Theme.of(context)
          //                                     .textTheme
          //                                     .bodyLarge,
          //                               ),
          //                               Text(AppLocalizations().TOTAL_BID_QTY,
          //                                   style: Theme.of(context)
          //                                       .textTheme
          //                                       .bodyLarge!
          //                                       .copyWith(
          //                                           fontSize: 12,
          //                                           fontWeight:
          //                                               FontWeight.w400)),
          //                             ],
          //                           ),
          //                         ),
          //                         Container(
          //                           width:
          //                               MediaQuery.of(context).size.width * 0.4,
          //                           child: Row(
          //                             mainAxisAlignment:
          //                                 MainAxisAlignment.spaceBetween,
          //                             children: [
          //                               Text(
          //                                 AppLocalizations().TOTAL_OFFER_QTY,
          //                                 style: Theme.of(context)
          //                                     .textTheme
          //                                     .bodyLarge!
          //                                     .copyWith(
          //                                         fontSize: 12,
          //                                         fontWeight: FontWeight.w400),
          //                               ),
          //                               Text(
          //                                 '7,73,699',
          //                                 style: Theme.of(context)
          //                                     .textTheme
          //                                     .bodyLarge,
          //                               ),
          //                             ],
          //                           ),
          //                         )
          //                       ],
          //                     ),
          //                     SizedBox(
          //                       height: AppWidgetSize.dimen_0,
          //                     ),
          //                   ],
          //                 ),
          //               );
          //             });
          //       },
          //       child: Row(
          //         children: [
          //           Container(
          //               height: 15, width: 15, child: AppImages.marketDepth),
          //           SizedBox(
          //             width: AppWidgetSize.dimen_5,
          //           ),
          //           Text(
          //             localizationTexts.depth,
          //             style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          //                 color: AppColors.primaryBlueV2,
          //                 fontWeight: FontWeight.w600,
          //                 fontSize: 12),
          //           ),
          //           SizedBox(
          //             width: AppWidgetSize.dimen_12,
          //           ),
          //         ],
          //       ),
          //     )
          //   ],
          // ),
          // SizedBox(
          //   height: AppWidgetSize.dimen_5,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     _filterOrderOptionButton(
          //         width: MediaQuery.of(context).size.width * 0.3,
          //         val: 'Market',
          //         getGrpVal: () => selectedOrder),
          //     _filterOrderOptionButton(
          //         width: MediaQuery.of(context).size.width * 0.3,
          //         val: 'Limit',
          //         getGrpVal: () => selectedOrder),
          //     _filterOrderOptionButton(
          //         width: MediaQuery.of(context).size.width * 0.3,
          //         val: 'SL',
          //         getGrpVal: () => selectedOrder),
          //   ],
          // ),
