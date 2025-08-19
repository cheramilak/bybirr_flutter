import 'package:bybirr_flutter/page/dashboard/dashboard_provider.dart';
import 'package:bybirr_flutter/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final double progressValue = 0.5;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    final DashboardProvider dashboardProvider =
        Provider.of<DashboardProvider>(context);
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: dashboardProvider.getScareenList[dashboardProvider.getCurrentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: dashboardProvider.getCurrentIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          onTap: (value) {
            dashboardProvider.setCurrentIndex = value;
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'Blog'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
          ]),
    );
  }
}