import 'package:bybirr_flutter/core/exception_message.dart';
import 'package:bybirr_flutter/page/auth/login_screan.dart';
import 'package:bybirr_flutter/page/auth/providers/auth_provider.dart';
import 'package:bybirr_flutter/page/dashboard/dashboard_screan.dart';
import 'package:bybirr_flutter/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class SignupScrean extends StatefulWidget {
  const SignupScrean({super.key});

  @override
  State<SignupScrean> createState() => _SignupScreanState();
}

class _SignupScreanState extends State<SignupScrean> {
  TextEditingController emailControoler = TextEditingController();
  TextEditingController firstControoler = TextEditingController();
  TextEditingController lastControoler = TextEditingController();
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
            const SizedBox(height: 20),
            Text(
              'Create account',
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            5.height,
            Text(
              'Please enter your name, email and password \n to create new account',
              style: theme.textTheme.labelMedium,
            ),
            5.height,
            const SizedBox(height: 20),
            textFormAuth(
              controller: firstControoler,
              labelText: 'First name',
              hintText: 'Enter your firts name',
              icon: Icons.person,
            ),
            textFormAuth(
              controller: lastControoler,
              labelText: 'Last name',
              hintText: 'Enter your last name',
              icon: Icons.person,
            ),
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
                    child: const Text(
                      'Signup',
                      style: TextStyle(
                        color: white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ).onTap(() async {
                    // DashboardScreen().launch(context,isNewTask: true);
                    String? check = validateInputs(
                      fName: firstControoler.text.trim(),
                      lName: lastControoler.text.trim(),
                      email: emailControoler.text.trim(),
                      password: passwordControoler.text,
                    );
                    if (check != null) {
                      return showErrorMessage(null, check);
                    }
                    bool res = await authProvider.signup(
                      firstName: firstControoler.text.trim(),
                      lastName: lastControoler.text.trim(),
                      email: emailControoler.text.trim(),
                      password: passwordControoler.text,
                    );
                    if (res) {
                      DashboardScreen().launch(context, isNewTask: true);
                    }
                  }),
            10.height,
            const SizedBox(height: 20),
            Align(
              alignment: AlignmentGeometry.center,
              child: GestureDetector(
                onTap: () {
                  LoginScrean().launch(context);
                },
                child: const Text(
                  'If you have account? Login',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
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

String? validateInputs({
  required String fName,
  required String lName,
  required String email,
  required String password,
}) {
  // Validate Name

  if (fName.isEmpty) {
    return 'First name cannot be empty';
  } else if (password.length < 3) {
    return 'first name must be at least 3 characters long';
  }

  if (lName.isEmpty) {
    return 'Last name cannot be empty';
  } else if (password.length < 3) {
    return 'Last name must be at least 6 characters long';
  }
  // Validate Email
  if (email.isEmpty) {
    return 'Email cannot be empty';
  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
    return 'Enter a valid email address';
  }

  // Validate Password
  if (password.isEmpty) {
    return 'Password cannot be empty';
  } else if (password.length < 6) {
    return 'Password must be at least 6 characters long';
  }
  return null;
}
