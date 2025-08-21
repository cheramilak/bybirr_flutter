import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class KycConformationDialog extends StatefulWidget {
  const KycConformationDialog({super.key});

  @override
  State<KycConformationDialog> createState() => _KycConformationDialogState();
}

class _KycConformationDialogState extends State<KycConformationDialog> {
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
            'KYC submission is now pending',
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      content: Text(
        "Your KYC submission has been received and is currently under review. Please wait while we process your documents.",
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
              return Navigator.pop(context);
            },
            child: Text('Back'),
          ),
        ),
      ],
    );
  }
}
