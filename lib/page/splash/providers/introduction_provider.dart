import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class IntroductionProvider extends ChangeNotifier {
  final PageController _pageController = PageController();
  int counter = 0;
  int index = 0;
  late Timer timer;
  PageController get getController => _pageController;

  void startTimer(int pageIndex) {
    // counter = 59;
    // if (timer.isActive) {
    //   timer.cancel();
    // }
    //counter = 0;

    timer = Timer.periodic(const Duration(milliseconds: 30), (Timer t) {
      if (counter == 100) {
        //t.cancel();
        if (index == 3) {
          index = 1;
        } else {
          index++;
        }

        counter = 0;
        notifyListeners();
      } else {
        counter++;
        notifyListeners();
      }
    });
  }

  set setIndex(int value) {
    index = value;
    notifyListeners();
  }

  void longTap() {
    timer.cancel();
  }

  void pageChanged(bool isNext) {
    _pageController.animateToPage(
      isNext
          ? getController.page!.toInt() + 1
          : getController.page!.toInt() - 1,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
