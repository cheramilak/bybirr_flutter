import 'package:bybirr_flutter/core/exception_message.dart';
import 'package:bybirr_flutter/page/auth/change_password_screen.dart';
import 'package:bybirr_flutter/page/auth/providers/auth_provider.dart';
import 'package:bybirr_flutter/page/auth/signup_screan.dart';
import 'package:bybirr_flutter/page/dashboard/dashboard_screan.dart';
import 'package:bybirr_flutter/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  final bool isnew;
  final String? token;
  const OtpScreen({super.key, required this.isnew, this.token});

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
            const SizedBox(height: 40),
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
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                ),
                child: OTPTextField(
                  pinLength: 6,
                  fieldWidth: 45, // Responsive width
                  boxDecoration: BoxDecoration(
                    border: Border.all(color: colorScheme.primary, width: 0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onCompleted: (value) {
                    print(value);
                    authProvider.setOtp = value;
                  },
                  onChanged: (value) {
                    print(value);
                    authProvider.setOtp = value;
                  },
                ),
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
            if (authProvider.counter > 0)
              Center(
                child: Text.rich(
                  TextSpan(
                    text: 'Resend The Code in ',
                    style: theme.textTheme.labelMedium!.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                    children: [
                      TextSpan(
                        text: '${authProvider.counter}',
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
            if (authProvider.counter == 0)
              authProvider.isLoadingOtp
                  ? SizedBox()
                  : Align(
                      alignment: AlignmentGeometry.center,
                      child:
                          Text(
                            'Resend',
                            style: theme.textTheme.labelLarge!.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ).onTap(() {
                            if (widget.isnew) {
                              authProvider.verifyEmail();
                            }
                            if (widget.token != null) {
                              authProvider.resendOtp(token: widget.token!);
                            }
                          }),
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
                      !widget.isnew ? 'Reset' : 'Verify',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ).onTap(() async {
                    if (authProvider.getOtp.isNotEmpty) {
                      if (widget.token != null) {
                        bool res = await authProvider.checkPasswordResetOtp(
                          token: widget.token!,
                          otp: authProvider.getOtp,
                        );
                        if (res) {
                          ChangePasswordScreen().launch(context);
                        }
                      }
                      if (widget.isnew) {
                        bool res = await authProvider.verifyOtp();
                        if (res) {
                          DashboardScreen().launch(context);
                        }
                      }
                    }
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
