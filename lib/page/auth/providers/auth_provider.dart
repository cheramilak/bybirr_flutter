import 'package:bybirr_flutter/core/exception_message.dart';
import 'package:bybirr_flutter/models/kyc.dart';
import 'package:bybirr_flutter/models/user_model.dart';
import 'package:bybirr_flutter/page/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? userModel;
  AuthRepository _repository = AuthRepository();
  bool isLoading = false;
  bool get getIsLoading => isLoading;
  bool isLoadingSplash = false;
  bool get getIsLoadingSplash => isLoadingSplash;
  set setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  set setIsLoadingSplash(bool value) {
    isLoadingSplash = value;
    notifyListeners();
  }

  UserModel? get getUser => userModel;

  set setUser(UserModel user) {
    userModel = user;
    notifyListeners();
  }

  set setKyc(KYCModel models) {
    userModel!.kycModel = models;
    notifyListeners();
  }

  Future<bool> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      setIsLoading = true;
      var res = await _repository.signup(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      );
      return res.fold(
        (error) {
          setIsLoading = false;
          print(error);
          showErrorMessage(null, error);
          return false;
        },
        (user) {
          setIsLoading = false;
          setUser = user;
          return true;
        },
      );
    } catch (e) {
      print(e.toString());
      setIsLoading = false;
      return false;
    }
  }

  Future<bool> Login({required String email, required String password}) async {
    try {
      setIsLoading = true;
      var res = await _repository.login(email: email, password: password);
      return res.fold(
        (error) {
          setIsLoading = false;
          print(error);
          showErrorMessage(null, error);
          return false;
        },
        (user) {
          setIsLoading = false;
          setUser = user;
          return true;
        },
      );
    } catch (e) {
      print(e.toString());
      setIsLoading = false;
      return false;
    }
  }

  Future<bool> getUserProfile() async {
    try {
      setIsLoadingSplash = true;
      var res = await _repository.getUserProfile();
      return res.fold(
        (l) {
          showErrorMessage(null, l);
          setIsLoadingSplash = false;
          return false;
        },
        (r) {
          setUser = r;
          setIsLoadingSplash = false;
          return true;
        },
      );
    } catch (e) {
      showErrorMessage(null, e.toString());
      setIsLoadingSplash = false;
      return false;
    }
  }
}
