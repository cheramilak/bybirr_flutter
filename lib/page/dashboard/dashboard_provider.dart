import 'package:bybirr_flutter/page/blog/blog_screen.dart';
import 'package:bybirr_flutter/page/home/home_screan.dart';
import 'package:bybirr_flutter/page/profile/profile_screen.dart';
import 'package:flutter/material.dart';


class DashboardProvider extends ChangeNotifier {
  int _currentIndex = 0;
  List<Widget> screenList = [
   HomeScrean(),
    BlogScreen(),
    ProfileScreen(),
  ];
  List<String> screenTitles = ['Home', 'Bloes', 'Profile',];
  List<Widget> get getScareenList => screenList;
  List<String> get getCurrentTitlte => screenTitles;
  int get getCurrentIndex => _currentIndex;
  set setCurrentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }
}