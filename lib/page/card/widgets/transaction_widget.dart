import 'package:bybirr_flutter/models/transaction_model.dart';
import 'package:bybirr_flutter/page/home/widgets/transaction_detail_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

class TransactionWidget extends StatelessWidget {
  final TransactionModel transaction;
  const TransactionWidget({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: colorScheme.surfaceBright,
        border: Border.all(
          width: 0.3,
          color: transaction.isSuccessful ? greenColor : redColor,
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: transaction.isSuccessful ? greenColor : redColor,
          child: Text(transaction.transactionIcon),
        ),
        title: Text(
          transaction.narrative ?? '',
          style: theme.textTheme.bodyLarge,
        ),
        subtitle: Text(
          DateFormat(
            'dd MMM',
          ).format(DateTime.parse(transaction.createdAt.toString())),
          style: theme.textTheme.bodySmall,
        ),
        trailing: Text.rich(
          TextSpan(
            text: '\$${transaction.amount} \n', // default text
            style: theme.textTheme.bodyMedium,
            children: <TextSpan>[
              TextSpan(
                text: DateFormat(
                  'HH:mm',
                ).format(DateTime.parse(transaction.createdAt.toString())),
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
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return TransactionDetailBottomSheet(transaction: transaction);
        },
      );
    });
  }
}
