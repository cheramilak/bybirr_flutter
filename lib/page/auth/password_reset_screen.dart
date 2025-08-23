import 'package:bybirr_flutter/core/exception_message.dart';
import 'package:bybirr_flutter/page/auth/otp_screen.dart';
import 'package:bybirr_flutter/page/auth/providers/auth_provider.dart';
import 'package:bybirr_flutter/page/auth/signup_screan.dart';
import 'package:bybirr_flutter/page/dashboard/dashboard_screan.dart';
import 'package:bybirr_flutter/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
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
            const SizedBox(height: 40),
            Text(
              'Forgot Password?',
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            5.height,
            Text(
              'Please enter your email address. We will send you an OTP \n code for verification in the next step',
              style: theme.textTheme.labelSmall,
            ),
            5.height,

            const SizedBox(height: 20),
            textFormAuth(
              controller: emailControoler,
              labelText: 'Email Address',
              hintText: 'Enter your email',
              icon: Icons.email,
            ),
            Expanded(child: SizedBox()),
            authProvider.getIsLoadingOtp
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
                  ).onTap(() async {
                    String? check = validateEmail(email: emailControoler.text);
                    if (check != null) {
                      return showErrorMessage(null, check);
                    }
                    authProvider
                        .foregetPassword(email: emailControoler.text)
                        .then((value) {
                          if (value != null) {
                            OtpScreen(
                              isnew: false,
                              token: value,
                            ).launch(context);
                          }
                        });
                  }),
            20.height,
          ],
        ).paddingAll(10),
      ),
    );
  }
}

String? validateEmail({required String email}) {
  // Validate Name

  // Validate Email
  if (email.isEmpty) {
    return 'Email cannot be empty';
  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
    return 'Enter a valid email address';
  }

  return null;
}
