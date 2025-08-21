import 'package:bybirr_flutter/core/exception_message.dart';
import 'package:bybirr_flutter/models/bank_model.dart';
import 'package:bybirr_flutter/page/card/providers/card_provider.dart';
import 'package:bybirr_flutter/page/card/widgets/payment_conformation_dialog.dart';
import 'package:bybirr_flutter/utils/style.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  final double amount;
  final BankModel bankModel;
  const PaymentScreen({
    super.key,
    required this.amount,
    required this.bankModel,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController transactionContrller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;
    CardProvider cardProvider = Provider.of<CardProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Payment')),
      body: Column(
        children: [
          10.height,
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text('Payment option', style: TextStyle(fontSize: 12)),
              ),
              5.width,
              Expanded(child: Container(height: 0.4, color: gray)),
            ],
          ),
          3.height,
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: gray.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(5),
              color: colorScheme.surface,
            ),
            child: Column(
              children: [
                ListTile(
                  dense: true,
                  title: const Text(
                    'Payment method',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    widget.bankModel.name,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Container(height: 0.4, color: gray),
                ListTile(
                  dense: true,
                  title: const Text(
                    'Account number',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    widget.bankModel.number,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Container(height: 0.4, color: gray),
                ListTile(
                  dense: true,
                  title: const Text(
                    'Account name',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    widget.bankModel.accountName,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          10.height,
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text('Payment detail', style: TextStyle(fontSize: 12)),
              ),
              5.width,
              Expanded(child: Container(height: 0.4, color: gray)),
            ],
          ),
          3.height,
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: gray.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(5),
              color: colorScheme.surface,
            ),
            child: Column(
              children: [
                ListTile(
                  dense: true,
                  title: const Text(
                    'Amount enterd',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    '\$${widget.amount}',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Container(height: 0.4, color: gray),
                ListTile(
                  dense: true,
                  title: const Text(
                    'Rate',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    cardProvider.getRate!.rate.toStringAsFixed(2),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Container(height: 0.4, color: gray),
                ListTile(
                  dense: true,
                  title: const Text(
                    'Total',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    "${cardProvider.getRate!.rate * widget.amount}",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          10.height,
          textFormAuth(
            controller: transactionContrller,
            labelText: 'Transaction',
            hintText: 'Transaction ref',
            icon: Icons.numbers,
          ),
          5.height,
          DottedBorder(
                options: RectDottedBorderOptions(
                  color: gray.withOpacity(0.5),
                  strokeWidth: 1,
                  dashPattern: [6, 3], // 5px dash, 3px gap
                ),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  alignment: Alignment.center,
                  child: cardProvider.getScreenshoot != null
                      ? Image.file(
                          cardProvider.getScreenshoot!,
                          fit: BoxFit.cover,
                        )
                      : Text('Screenshot', style: theme.textTheme.displaySmall),
                ),
              )
              .onTap(() {
                cardProvider.pickScreensoot();
              })
              .paddingAll(5),
          Expanded(child: SizedBox()),
          ElevatedButton(
            onPressed: () async {
              if (cardProvider.getScreenshoot == null) {
                return showErrorMessage(
                  null,
                  'Screenshot of transaction is required',
                );
              }
              if (transactionContrller.text.isEmpty) {
                return showErrorMessage(
                  null,
                  'Transaction refrense number is required',
                );
              } else {
                bool res = await cardProvider.orderCard(
                  amount: widget.amount.toString(),
                  transactionId: transactionContrller.text.trim(),
                  bankId: widget.bankModel.id,
                );
                if (res) {
                  return showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return PaymentConformationDialog();
                    },
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: cardProvider.getLoadingPayment
                ? LoadingAnimationWidget.staggeredDotsWave(
                    color: theme.colorScheme.onPrimary,
                    size: 25,
                  )
                : Text(
                    'Submit',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
          ),
          5.height,
        ],
      ),
    );
  }
}
