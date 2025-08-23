import 'package:bybirr_flutter/core/exception_message.dart';
import 'package:bybirr_flutter/models/user_model.dart';
import 'package:bybirr_flutter/page/auth/email_verification_screen.dart';
import 'package:bybirr_flutter/page/auth/otp_screen.dart';
import 'package:bybirr_flutter/page/auth/password_reset_screen.dart';
import 'package:bybirr_flutter/page/auth/providers/auth_provider.dart';
import 'package:bybirr_flutter/page/auth/signup_screan.dart';
import 'package:bybirr_flutter/page/dashboard/dashboard_screan.dart';
import 'package:bybirr_flutter/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class LoginScrean extends StatefulWidget {
  const LoginScrean({super.key});

  @override
  State<LoginScrean> createState() => _LoginScreanState();
}

class _LoginScreanState extends State<LoginScrean> {
  TextEditingController emailControoler = TextEditingController();
  TextEditingController passwordControoler = TextEditingController();
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
              'Hello There!',
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            5.height,
            Text(
              'Please enter your email and password \n to continue',
              style: theme.textTheme.labelMedium,
            ),
            5.height,

            const SizedBox(height: 20),
            textFormAuth(
              controller: emailControoler,
              labelText: 'Email Address',
              hintText: 'Enter your email',
              icon: Icons.email,
            ),
            passwordFormAuth(
              controller: passwordControoler,
              labelText: 'Password',
              hintText: 'Enter your password',
              isPasswordVisible: true,
              onVisibilityToggle: () {},
            ),
            10.height,
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  PasswordResetScreen().launch(context);
                },
                child: const Text(
                  'Forget Password?',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.left,
                ),
              ),
            ).paddingRight(10),
            const SizedBox(height: 13),
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
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ).onTap(() async {
                    String? check = validateInputs(
                      email: emailControoler.text.trim(),
                      password: passwordControoler.text,
                    );
                    if (check != null) {
                      return showErrorMessage(null, check);
                    }
                    UserModel? res = await authProvider.Login(
                      email: emailControoler.text.trim(),
                      password: passwordControoler.text,
                    );
                    if (res != null) {
                      if (res.emailVerifiedAt == null) {
                        return EmailVerificationScreen().launch(context);
                      } else {
                        DashboardScreen().launch(context, isNewTask: true);
                      }
                    }
                  }),
            10.height,
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  SignupScrean().launch(context);
                },
                child: const Text('Don\'t have an account? Sign up'),
              ),
            ),
            Expanded(child: SizedBox()),
            Row(
              children: [
                Expanded(child: Container(height: 0.4, color: gray)),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Or continue with',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                5.width,
                Expanded(child: Container(height: 0.4, color: gray)),
              ],
            ),
            10.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                10.width,
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isDark ? Colors.white : Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.email),
                  ),
                ),
                10.width,
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isDark ? Colors.white : Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.facebook),
                  ),
                ),
                10.width,
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isDark ? Colors.white : Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.apple),
                  ),
                ),
                10.width,
              ],
            ),
            10.height,
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
