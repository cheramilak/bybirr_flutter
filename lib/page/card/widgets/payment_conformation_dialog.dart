import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class PaymentConformationDialog extends StatefulWidget {
  const PaymentConformationDialog({super.key});

  @override
  State<PaymentConformationDialog> createState() =>
      _PaymentConformationDialogState();
}

class _PaymentConformationDialogState extends State<PaymentConformationDialog> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return AlertDialog(
      backgroundColor: colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Icon(Icons.cancel, size: 30, color: colorScheme.error).onTap(
              () {
                Navigator.pop(context);
                return Navigator.pop(context);
              },
            ),
          ),
          Icon(
            Icons.warning_amber_outlined,
            size: 48,
            color: colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Payment Conformation',
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      content: Text(
        "Your payment has been recived successfuly,Your payment is under review now. This process may take some time. You will be notified once your verification is completed. Please check back later.",
        style: theme.textTheme.bodyLarge?.copyWith(
          color: colorScheme.onSurface,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              return Navigator.pop(context);
            },
            child: Text('Back'),
          ),
        ),
      ],
    );
  }
}
