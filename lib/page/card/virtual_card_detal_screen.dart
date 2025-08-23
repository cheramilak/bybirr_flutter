import 'package:bybirr_flutter/page/home/widgets/shimmer_loading_widget.dart';
import 'package:bybirr_flutter/page/home/widgets/transaction_detail_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class VirtualCardDetailScreen extends StatelessWidget {
  final String cardHolderName;
  final String cardNumber;
  final String expiryDate;
  final String cvv;
  final String balance;
  final String cardType; // e.g. "Visa", "Mastercard"

  const VirtualCardDetailScreen({
    super.key,
    required this.cardHolderName,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
    required this.balance,
    required this.cardType,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text("Virtual Card")),
      body: SingleChildScrollView(
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
                      cardType,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    cardNumber.replaceAllMapped(
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
                            cardHolderName.toUpperCase(),
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
                            expiryDate,
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
                            cvv,
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
                border: Border.all(color: Colors.grey.shade300, width: 0.8),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _cardDetailWidget(
                        theme,
                        colorScheme,
                        'Available Balance',
                        '\$1,200.50',
                      ),
                      _cardDetailWidget(
                        theme,
                        colorScheme,
                        'Billing Country',
                        'United States',
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
                        'Card Currency',
                        'USD',
                      ),
                      _cardDetailWidget(
                        theme,
                        colorScheme,
                        'Card Network',
                        cardType,
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
                        '10001',
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
                        '123 Main St',
                      ),
                      _cardDetailWidget(theme, colorScheme, 'Status', 'Active'),
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
                _buildActionButton(Icons.lock, "Freeze Card", colorScheme),
                _buildActionButton(Icons.qr_code, "View Details", colorScheme),
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
                itemCount: 10,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return false
                      ? KycShimmerWidget()
                      : Container(
                          margin: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: colorScheme.surfaceBright,
                            border: Border.all(width: 0.3),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(),
                            title: Text(
                              'Title',
                              style: theme.textTheme.bodyLarge,
                            ),
                            subtitle: Text(
                              '20 dec',
                              style: theme.textTheme.bodySmall,
                            ),
                            trailing: Text.rich(
                              TextSpan(
                                text: '\$34.34 \n', // default text
                                style: theme.textTheme.bodyMedium,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '12:34 pm',
                                    style: theme.textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ).onTap(() {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (context) {
                              return const TransactionDetailBottomSheet(
                                title: "Amazon Purchase",
                                amount: "\$34.34",
                                date: "20 Dec 2025",
                                time: "12:34 PM",
                                status: "Completed",
                                referenceId: "TXN123456789",
                              );
                            },
                          );
                        });
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
