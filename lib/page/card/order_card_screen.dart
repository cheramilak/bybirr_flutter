import 'package:bybirr_flutter/core/endpoint.dart';
import 'package:bybirr_flutter/core/exception_message.dart';
import 'package:bybirr_flutter/page/card/payment_screen.dart';
import 'package:bybirr_flutter/page/card/providers/card_provider.dart';
import 'package:bybirr_flutter/utils/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class OrderCardScreen extends StatefulWidget {
  const OrderCardScreen({super.key});

  @override
  State<OrderCardScreen> createState() => _OrderCardScreenState();
}

class _OrderCardScreenState extends State<OrderCardScreen> {
  TextEditingController amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CardProvider>(context, listen: false).fatchRate();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;
    CardProvider cardProvider = Provider.of<CardProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Order new Card')),
      body: cardProvider.getRate == null
          ? Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: greenColor,
                size: 25,
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                15.height,
                Text(
                  'You can create a new virtual card for your desired amount. Please enter the amount you wish to load onto your card and confirm your request.',
                  style: theme.textTheme.titleSmall,
                ),
                10.height,
                Form(
                  key: _formKey,
                  child: numberFormInput(
                    labelText: 'Amount',
                    hintText: 'Amount in usd',
                    max: cardProvider.getRate!.max,
                    min: cardProvider.getRate!.min,
                    controller: amountController,
                  ),
                ),
                10.height,
                Text(
                  'Current rate \$${cardProvider.getRate!.rate}',
                  style: theme.textTheme.labelLarge,
                ),
                Text(
                  'Limit \$${cardProvider.getRate!.min} - \$${cardProvider.getRate!.max}',
                  style: theme.textTheme.labelLarge,
                ),
                10.height,
                Text('Payment option', style: theme.textTheme.titleLarge),
                HorizontalList(
                  itemCount: cardProvider.getBankList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: cardProvider.selectBankIndex == index
                            ? greenColor
                            : colorScheme.surfaceBright,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: CachedNetworkImageProvider(
                              "$endpointImage${cardProvider.getBankList[index].image}",
                            ),
                          ),
                          10.height,
                          Text(
                            cardProvider.getBankList[index].code,
                            style: theme.textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ).onTap(() {
                      cardProvider.setSelectedBank = index;
                    });
                  },
                ),
                Expanded(child: SizedBox()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (cardProvider.selectBankIndex == -1) {
                            return showErrorMessage(
                              null,
                              'Select payment option',
                            );
                          } else {
                            PaymentScreen(
                              amount: amountController.text.toDouble(),
                              bankModel: cardProvider
                                  .bankList[cardProvider.selectBankIndex],
                            ).launch(context);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        'Next',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    10.width,
                  ],
                ),
                10.height,
              ],
            ),
    );
  }
}
