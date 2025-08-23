import 'package:bybirr_flutter/core/dio_config.dart';
import 'package:bybirr_flutter/core/user_data.dart';
import 'package:bybirr_flutter/page/auth/email_verification_screen.dart';
import 'package:bybirr_flutter/page/auth/login_screan.dart';
import 'package:bybirr_flutter/page/auth/providers/auth_provider.dart';
import 'package:bybirr_flutter/page/dashboard/dashboard_screan.dart';
import 'package:bybirr_flutter/page/splash/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    await DioClient().getAuthToken().then((e) {
      if (e.isEmpty) {
        // Make sure the widget is still mounted before navigating

        return IntroductionScreen().launch(context, isNewTask: true);
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Provider.of<AuthProvider>(
            context,
            listen: false,
          ).getUserProfile().then((e) {
            if (e == 'success') {
              return DashboardScreen().launch(context, isNewTask: true);
            } else if (e == 'Unauthenticated.') {
              DioClient().deltetAuthToken();
              return LoginScrean().launch(context, isNewTask: true);
            }
            if (e == 'notVerified') {
              return EmailVerificationScreen().launch(context, isNewTask: true);
            }
          });
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colorScheme = theme.colorScheme;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              //backgroundImage: AssetImage('assets/images/logo.JPG'),
              radius: 50,
            ),
            const SizedBox(height: 20),
            Text('Bybirr', style: theme.textTheme.titleLarge),
            const SizedBox(height: 20),
            LoadingAnimationWidget.inkDrop(
              color: colorScheme.primary,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
