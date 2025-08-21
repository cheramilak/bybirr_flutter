import 'package:bybirr_flutter/page/kyc/kyc_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class VirificationPendingDilaog extends StatefulWidget {
  const VirificationPendingDilaog({super.key});

  @override
  State<VirificationPendingDilaog> createState() =>
      _VirificationPendingDilaogState();
}

class _VirificationPendingDilaogState extends State<VirificationPendingDilaog> {
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
            'Pending Verification',
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      content: Text(
        "Your identity verification is currently under review. This process may take some time. You will be notified once your verification is completed. Please check back later.",
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

class VirificationStartDilaog extends StatefulWidget {
  const VirificationStartDilaog({super.key});

  @override
  State<VirificationStartDilaog> createState() =>
      _VirificationStartDilaogState();
}

class _VirificationStartDilaogState extends State<VirificationStartDilaog> {
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
            'Identity Verification Required',
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      content: Text(
        "To ensure the security of your account and comply with financial regulations, we require you to complete identity verification before accessing and using your virtual card. Please submit your valid identification documents to continue.",
        style: theme.textTheme.labelMedium?.copyWith(
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
              KycScreen().launch(context);
            },
            child: Text('Start'),
          ),
        ),
      ],
    );
  }
}

class VirificationFailDilaog extends StatefulWidget {
  const VirificationFailDilaog({super.key});

  @override
  State<VirificationFailDilaog> createState() => _VirificationFailDilaogState();
}

class _VirificationFailDilaogState extends State<VirificationFailDilaog> {
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
            'Failed Verification',
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      content: Text(
        "We were unable to verify your identity. Please review your information and resubmit the required documents. If the issue continues, contact our support team for assistance.",
        style: theme.textTheme.labelMedium?.copyWith(
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
              KycScreen().launch(context);
            },
            child: Text('Resubmit'),
          ),
        ),
      ],
    );
  }
}
