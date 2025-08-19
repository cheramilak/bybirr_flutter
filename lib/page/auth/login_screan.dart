import 'package:bybirr_flutter/page/auth/signup_screan.dart';
import 'package:bybirr_flutter/page/dashboard/dashboard_screan.dart';
import 'package:bybirr_flutter/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nb_utils/nb_utils.dart';

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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const CircleAvatar(
              radius: 50,
              backgroundColor: blueColor,
            ),
            const SizedBox(height: 20),
            const Text(
              'Log In',
              style: TextStyle(
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            textFormAuth(
              controller: emailControoler,
              labelText: 'Email Address',
              hintText: 'Enter your email',
              icon: Icons.email,
            ),
            const SizedBox(height: 20),
            passwordFormAuth(
              controller: passwordControoler,
              labelText: 'Password',
              hintText: 'Enter your password',
              isPasswordVisible: true,
              onVisibilityToggle: () {
                
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  
                },
                child: const Text(
                  'Forget password?',
                  style: TextStyle(
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ).paddingRight(10),
            const SizedBox(height: 13),
            false
                ? Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                        color: greenColor, size: 30))
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: fxPrimaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Login',
                      style:
                          TextStyle(color: white, fontWeight: FontWeight.bold),
                    ),
                  ).onTap(() async {
                    DashboardScreen().launch(context);
                  }),
            10.height,
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                SignupScrean().launch(context);
              },
              child: const Text(
                'If have not account? Sign up',
                style: TextStyle(
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}

String? validateInputs({
  required String email,
  required String password,
}) {
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
  } else if (password.length < 6) {
    return 'Password must be at least 6 characters long';
  }
  return null;
}