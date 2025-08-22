import 'package:bybirr_flutter/core/exception_message.dart';
import 'package:bybirr_flutter/page/auth/providers/auth_provider.dart';
import 'package:bybirr_flutter/page/auth/signup_screan.dart';
import 'package:bybirr_flutter/page/dashboard/dashboard_screan.dart';
import 'package:bybirr_flutter/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController emailControoler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colorScheme = theme.colorScheme;
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'You\'ve Got an Mail',
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            5.height,
            Text(
              'We have sent you an OTP verification code to your \n email address. Check your inbox and enter the code below',
              style: theme.textTheme.labelSmall,
            ),
            5.height,

            const SizedBox(height: 20),
            Align(
              alignment: AlignmentGeometry.center,
              child: OTPTextField(
                pinLength: 5,
                fieldWidth: 60,
                boxDecoration: BoxDecoration(
                  border: Border.all(color: colorScheme.primary, width: 0.3),
                ),
                onCompleted: (value) {
                  print(value);
                },
              ),
            ),
            15.height,
            Center(
              child: Text(
                'Didn\'t Receive email?',
                style: theme.textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
            ),
            5.height,
            Center(
              child: Text.rich(
                TextSpan(
                  text: 'Resend The Code in',
                  style: theme.textTheme.labelMedium!.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                  children: [
                    TextSpan(
                      text: ' 01:30',
                      style: theme.textTheme.labelMedium!.copyWith(
                        color: theme.colorScheme.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(child: SizedBox()),
            authProvider.getIsLoading
                ? Center(
                    child: LoadingAnimationWidget.inkDrop(
                      color: colorScheme.primary,
                      size: 30,
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ).onTap(() async {}),
            20.height,
          ],
        ).paddingAll(10),
      ),
    );
  }
}

String? validateInputs({required String email, required String password}) {
  // Validate Name

  // Validate Email
  if (email.isEmpty) {
    return 'Email cannot be empty';
  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
    return 'Enter a valid email address';
  }

  // Validate Password
  if (password.isEmpty) {
    return 'Password cannot be empty';
  }
  return null;
}
