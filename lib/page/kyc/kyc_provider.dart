import 'dart:io';
import 'package:bybirr_flutter/core/exception_message.dart';
import 'package:bybirr_flutter/models/kyc.dart';
import 'package:bybirr_flutter/page/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

class KycProvider extends ChangeNotifier {
  AuthRepository _repository = AuthRepository();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailControoler = TextEditingController();
  TextEditingController fNameControoler = TextEditingController();
  TextEditingController lNameControoler = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController cityControoler = TextEditingController();
  TextEditingController line1Controoler = TextEditingController();
  TextEditingController zipCodeControoler = TextEditingController();
  TextEditingController houseNumberControoler = TextEditingController();
  TextEditingController idNumberControoler = TextEditingController();

  bool isLoading = false;
  bool get getIsLoading => isLoading;
  File? idFront, idBack, selfieImage;
  File? get getFront => idFront;
  File? get getBack => idBack;
  File? get getSelfie => selfieImage;

  final ImagePicker _picker = ImagePicker();

  void initData(KYCModel? model) {
    if (model != null) {
      phoneController = TextEditingController(text: model.phone);
      fNameControoler = TextEditingController(text: model.fName);
      lNameControoler = TextEditingController(text: model.lName);
      emailControoler = TextEditingController(text: model.email);
      cityControoler = TextEditingController(text: model.city);
      stateController = TextEditingController(text: model.address);
      houseNumberControoler = TextEditingController(text: model.houseNumber);
      zipCodeControoler = TextEditingController(text: model.zipCode);
      line1Controoler = TextEditingController(text: model.line1);
      idNumberControoler = TextEditingController(text: model.idNumber);
      //dobController = TextEditingController(text: model.bod.toLocal());
      notifyListeners();
    }
  }

  Future<void> pickFront(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        idFront = File(pickedFile.path);
        notifyListeners();
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> pickBack(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        idBack = File(pickedFile.path);
        notifyListeners();
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> takeSelfie() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
      );
      if (pickedFile != null) {
        selfieImage = File(pickedFile.path);
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

  int index = 0;
  int get getIndex => index;

  set setIndex(int value) {
    index = value;
    notifyListeners();
  }

  set setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void backPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Future<KYCModel?> submitForm() async {
    if (isLoading) return null;
    try {
      setIsLoading = true;
      var res = await _repository.setKYC(
        firstName: fNameControoler.text.trim(),
        lastName: lNameControoler.text.trim(),
        email: emailControoler.text.trim(),
        phone: phoneController.text.trim(),
        state: stateController.text.trim(),
        city: cityControoler.text.trim(),
        houseNumber: houseNumberControoler.text.trim(),
        zipCode: zipCodeControoler.text.trim(),
        line1: line1Controoler.text.trim(),
        bod: dobController.text,
        idNumber: idNumberControoler.text.trim(),
        idFront: idFront,
        idBack: idBack,
        photo: selfieImage,
      );
      return res.fold(
        (l) {
          setIsLoading = false;
          showErrorMessage(null, l);
        },
        (r) {
          setIsLoading = false;
          return r;
        },
      );
    } catch (e) {
      setIsLoading = false;
      showErrorMessage(null, e.toString());
      return null;
    }
  }
}
