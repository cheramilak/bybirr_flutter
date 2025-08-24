import 'dart:ffi';

import 'package:bybirr_flutter/core/app_theme.dart';
import 'package:bybirr_flutter/page/auth/login_screan.dart';
import 'package:bybirr_flutter/page/auth/providers/auth_provider.dart';
import 'package:bybirr_flutter/page/blog/blog_provider.dart';
import 'package:bybirr_flutter/page/card/order_card_screen.dart';
import 'package:bybirr_flutter/page/card/providers/card_provider.dart';
import 'package:bybirr_flutter/page/dashboard/dashboard_provider.dart';
import 'package:bybirr_flutter/page/dashboard/dashboard_screan.dart';
import 'package:bybirr_flutter/page/home/providers/home_provider.dart';
import 'package:bybirr_flutter/page/kyc/kyc_provider.dart';
import 'package:bybirr_flutter/page/kyc/kyc_screen.dart';
import 'package:bybirr_flutter/page/splash/introduction_screen.dart';
import 'package:bybirr_flutter/page/splash/providers/introduction_provider.dart';
import 'package:bybirr_flutter/page/splash/splash_screen.dart';
import 'package:bybirr_flutter/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  ThemeProvider themeProvider = ThemeProvider();
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    themeProvider.setDarkMode = themeProvider.getIsDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            return themeProvider;
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return DashboardProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return BlogProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return KycProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return AuthProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return IntroductionProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return CardProvider();
          },
        ),
        ChangeNotifierProxyProvider<AuthProvider, HomeProvider>(
          create: (_) => HomeProvider(AuthProvider()),
          update: (_, auth, __) => HomeProvider(auth),
        ),
      ],
      builder: (context, snapshot) {
        ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          scaffoldMessengerKey: scaffoldMessengerKey,
          theme: themeProvider.getIsDarkMode
              ? AppTheme.dark.copyWith(
                  appBarTheme: AppBarTheme(elevation: 3),
                  textTheme: GoogleFonts.poppinsTextTheme(
                    ThemeData.dark().textTheme,
                  ),
                )
              : AppTheme.light.copyWith(
                  appBarTheme: AppBarTheme(elevation: 3),
                  textTheme: GoogleFonts.poppinsTextTheme(
                    ThemeData.light().textTheme,
                  ),
                ),
          home: SplashScreen(),
        );
      },
    );
  }
}
