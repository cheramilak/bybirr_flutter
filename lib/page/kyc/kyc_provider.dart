import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

class KycProvider extends ChangeNotifier {

  bool isAvatorLoading = false;

  bool isLoading = false;
  int _selectedAvatar = -1;
  String? _selectedGender;
  bool get getIsLoading => isLoading;

  int get getSelectedAvatar => _selectedAvatar;
  String? get getSelectedGender => _selectedGender;

  set setSelectedVavater(int id) {
    _selectedAvatar = id;
    _image = null;
    notifyListeners();
  }



  set setSelectedGender(String sex) {
    _selectedGender = sex;
    notifyListeners();
  }



  toogleIsLoading() {
    isLoading = !getIsLoading;
    notifyListeners();
  }

  File? _image;
  File? get getImage => _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        notifyListeners();
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  DateTime? _selectedDate;

  DateTime? get getSelectedDate => _selectedDate;

  Future<void> pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      _selectedDate = pickedDate;
      notifyListeners();
    }
  }

  PageController _pageController = PageController(viewportFraction: 1);
  PageController get getController => _pageController;

  int forexLeve = -1;
  int index = 0;
  int selectedAgeRange = -1;
  int selectGender = -1;
  int educationLevel = -1;
  int get getIndex => index;
  int get getForexLevel => forexLeve;
  int get getSelectedAgeRange => selectedAgeRange;
  int get getSelectedSex => selectGender;
  int get getEducationLevel => educationLevel;

  set setForexLevel(int value) {
    forexLeve = value;
    notifyListeners();
  }

  set setIndex(int value) {
    index = value;
    notifyListeners();
  }

  set setSelectedAgeRange(int value) {
    selectedAgeRange = value;
    notifyListeners();
  }

  set setSelectedSex(int value) {
    selectGender = value;
    notifyListeners();
  }

  set setEducationLevel(int value) {
    educationLevel = value;
    notifyListeners();
  }

  void nextPage() {
    index++;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  ScrollPhysics getScrollPhysics() {
    if (getIndex == 0) {
      if (getForexLevel == -1) {
        return const NeverScrollableScrollPhysics();
      }
    }
    if (getIndex == 1) {
      if (getEducationLevel == -1) {
        return const NeverScrollableScrollPhysics();
      }
    }
    if (getIndex == 2) {
      if (getImage == null && getSelectedAvatar == -1) {
        return const NeverScrollableScrollPhysics();
      }
    }
    if (getIndex == 3) {
      if (getSelectedAgeRange == -1) {
        return const NeverScrollableScrollPhysics();
      }
    }
    return const ScrollPhysics();
  }

  List<Color> colorList = [
    redColor,
    blueColor,
    greenColor,
    yellow,
    purple,
  ];
  List<Color> get getColorList => colorList;
}
