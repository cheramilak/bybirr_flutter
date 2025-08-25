import 'package:bybirr_flutter/models/virtual_card_model.dart';
import 'package:bybirr_flutter/page/card/providers/card_provider.dart';
import 'package:bybirr_flutter/page/card/widgets/transaction_widget.dart';
import 'package:bybirr_flutter/page/home/widgets/shimmer_loading_widget.dart';
import 'package:bybirr_flutter/page/home/widgets/transaction_detail_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class VirtualCardDetailScreen extends StatefulWidget {
  final String cardId;
  const VirtualCardDetailScreen({super.key, required this.cardId});

  @override
  State<VirtualCardDetailScreen> createState() =>
      _VirtualCardDetailScreenState();
}

class _VirtualCardDetailScreenState extends State<VirtualCardDetailScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<CardProvider>(
        context,
        listen: false,
      ).fatchCardDetail(widget.cardId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final cardProvider = Provider.of<CardProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Virtual Card")),
      body: cardProvider.getVirtualCardModel == null
          ? Center(
              child: LoadingAnimationWidget.fallingDot(
                color: theme.primaryColor,
                size: 30,
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // --- Card Preview ---
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        colors: [colorScheme.primary, colorScheme.secondary],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            cardProvider.getVirtualCardModel!.cardholderName,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          cardProvider.getVirtualCardModel!.cardNumber
                              .replaceAllMapped(
                                RegExp(r".{4}"),
                                (match) => "${match.group(0)} ",
                              ),
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Card Holder",
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: Colors.white70,
                                  ),
                                ),
                                Text(
                                  cardProvider
                                      .getVirtualCardModel!
                                      .cardholderName
                                      .toUpperCase(),
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Expires",
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: Colors.white70,
                                  ),
                                ),
                                Text(
                                  cardProvider.getVirtualCardModel!.valid,
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "CVV",
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: Colors.white70,
                                  ),
                                ),
                                Text(
                                  cardProvider.getVirtualCardModel!.cvv,
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // --- Balance Info ---
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 0.8,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _cardDetailWidget(
                              theme,
                              colorScheme,
                              'Available Balance',
                              '\$${cardProvider.getVirtualCardModel!.balance}',
                            ),
                            _cardDetailWidget(
                              theme,
                              colorScheme,
                              'Billing Country',
                              '${cardProvider.getVirtualCardModel!.billingAddress?.country}',
                            ),
                          ],
                        ),
                        5.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _cardDetailWidget(
                              theme,
                              colorScheme,
                              'Billing State',
                              "${cardProvider.getVirtualCardModel!.billingAddress?.state}",
                            ),
                            _cardDetailWidget(
                              theme,
                              colorScheme,
                              'Billing City',
                              "${cardProvider.getVirtualCardModel!.billingAddress?.city}",
                            ),
                          ],
                        ),
                        5.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _cardDetailWidget(
                              theme,
                              colorScheme,
                              'Billing City',
                              'New York',
                            ),
                            _cardDetailWidget(
                              theme,
                              colorScheme,
                              'Billing Zip Code',
                              "${cardProvider.getVirtualCardModel!.billingAddress?.zipCode}",
                            ),
                          ],
                        ),
                        5.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _cardDetailWidget(
                              theme,
                              colorScheme,
                              'Billing Street',
                              "${cardProvider.getVirtualCardModel!.billingAddress?.street}",
                            ),
                            _cardDetailWidget(
                              theme,
                              colorScheme,
                              'Status',
                              cardProvider.getVirtualCardModel!.status,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),
                  // --- Card Actions ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(
                        Icons.lock,
                        "Freeze Card",
                        colorScheme,
                      ),
                      _buildActionButton(
                        Icons.qr_code,
                        "View Details",
                        colorScheme,
                      ),
                      _buildActionButton(Icons.delete, "Delete", colorScheme),
                      _buildActionButton(Icons.delete, "Delete", colorScheme),
                    ],
                  ),
                  10.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Transactions',
                        style: theme.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  10.height,
                  SizedBox(
                    child: ListView.builder(
                      itemCount: cardProvider.getLoadingTransactions
                          ? 10
                          : cardProvider.getTransactionList.length,
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return cardProvider.getLoadingTransactions
                            ? KycShimmerWidget()
                            : TransactionWidget(
                                transaction:
                                    cardProvider.getTransactionList[index],
                              );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Column _cardDetailWidget(
    ThemeData theme,
    ColorScheme colorScheme,
    String title,
    String value,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.bodySmall?.copyWith(
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: theme.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, ColorScheme scheme) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: scheme.primary.withOpacity(0.1),
          child: Icon(icon, color: scheme.primary),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: scheme.primary,
          ),
        ),
      ],
    );
  }
}
