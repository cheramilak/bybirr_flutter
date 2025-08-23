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

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
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
              'Create New Password',
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            5.height,
            Text(
              'Please enter your new password.',
              style: theme.textTheme.labelSmall,
            ),
            5.height,

            const SizedBox(height: 20),
            passwordFormAuth(
              controller: emailControoler,
              labelText: 'New password',
              hintText: 'Enter new password',
              isPasswordVisible: false,
              onVisibilityToggle: () {},
            ),
            passwordFormAuth(
              controller: emailControoler,
              labelText: 'Confirm Password',
              hintText: 'Re-enter your new password',
              isPasswordVisible: false,
              onVisibilityToggle: () {},
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
                      'Continue',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ).onTap(() async {
                    DashboardScreen().launch(context);
                  }),
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
