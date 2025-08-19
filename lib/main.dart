import 'package:bybirr_flutter/core/app_theme.dart';
import 'package:bybirr_flutter/page/auth/login_screan.dart';
import 'package:bybirr_flutter/page/dashboard/dashboard_provider.dart';
import 'package:bybirr_flutter/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
    themeProvider.setDarkMode =  themeProvider.getIsDarkMode;
    
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_){
           return themeProvider;
          }),
           ChangeNotifierProvider(create: (_){
           return DashboardProvider();
          }),
        ],
        builder: (context, snapshot) {
          ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
         
          return MaterialApp(
           
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
          //  scaffoldMessengerKey: scaffoldMessengerKey,
            theme: themeProvider.getIsDarkMode
                ? AppTheme.dark.copyWith(
                    appBarTheme: AppBarTheme(elevation: 3),
                    textTheme: GoogleFonts.poppinsTextTheme(
                        ThemeData.dark().textTheme),
                  )
                : AppTheme.light.copyWith(
                    appBarTheme: AppBarTheme(elevation: 3),
                    textTheme: GoogleFonts.poppinsTextTheme(
                        ThemeData.light().textTheme)),
           home: LoginScrean(),
          );
        });
  }
}