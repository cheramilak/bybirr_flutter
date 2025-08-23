import 'dart:async';

import 'package:bybirr_flutter/core/exception_message.dart';
import 'package:bybirr_flutter/models/kyc.dart';
import 'package:bybirr_flutter/models/user_model.dart';
import 'package:bybirr_flutter/page/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? userModel = UserModel(
    firstName: '',
    lastName: '',
    email: '',
    status: '',
    cards: [],
  );
  AuthRepository _repository = AuthRepository();
  bool isLoading = false;
  bool isLoadingOtp = false;
  bool isSentOtp = false;
  bool get getIsLoading => isLoading;
  bool isLoadingSplash = false;
  bool get getIsLoadingSplash => isLoadingSplash;
  bool get getIsLoadingOtp => isLoadingOtp;
  bool get getIsSentOtp => isSentOtp;

  set setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  set setIsSentOtp(bool value) {
    isSentOtp = value;
    notifyListeners();
  }

  set setIsLoadingOtp(bool value) {
    isLoadingOtp = value;
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

  Future<UserModel?> Login({
    required String email,
    required String password,
  }) async {
    try {
      setIsLoading = true;
      var res = await _repository.login(email: email, password: password);
      return res.fold(
        (error) {
          setIsLoading = false;
          print(error);
          showErrorMessage(null, error);
          return null;
        },
        (user) {
          setIsLoading = false;
          setUser = user;
          return user;
        },
      );
    } catch (e) {
      print(e.toString());
      setIsLoading = false;
      return null;
    }
  }

  Future<String> getUserProfile() async {
    try {
      setIsLoadingSplash = true;
      var res = await _repository.getUserProfile();
      return res.fold(
        (l) {
          showErrorMessage(null, l);
          setIsLoadingSplash = false;
          return l;
        },
        (r) {
          setUser = r;
          setIsLoadingSplash = false;
          if (r.emailVerifiedAt == null) {
            return 'notVerified';
          }
          return 'success';
        },
      );
    } catch (e) {
      showErrorMessage(null, e.toString());
      setIsLoadingSplash = false;
      return e.toString();
    }
  }

  Future<bool> verifyEmail() async {
    try {
      setIsLoadingOtp = true;
      var res = await _repository.emailVerification();
      return res.fold(
        (error) {
          setIsLoadingOtp = false;
          print(error);
          showErrorMessage(null, error);
          return false;
        },
        (success) {
          setIsLoadingOtp = false;
          startTimer();
          return true;
        },
      );
    } catch (e) {
      print(e.toString());
      setIsLoadingOtp = false;
      return false;
    }
  }

  Timer? timer;
  int counter = 0;
  void startTimer() {
    counter = 59;
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (counter == 0) {
        t.cancel();
        notifyListeners();
      } else {
        counter--;
        notifyListeners();
      }
    });
  }

  String otp = '';
  String get getOtp => otp;
  set setOtp(String value) {
    otp = value;
    notifyListeners();
  }

  Future<bool> verifyOtp() async {
    try {
      setIsLoadingOtp = true;
      var res = await _repository.verifyOtp(otp: otp);
      return res.fold(
        (error) {
          setIsLoadingOtp = false;
          print(error);
          showErrorMessage(null, error);
          return false;
        },
        (success) {
          setIsLoadingOtp = false;
          return true;
        },
      );
    } catch (e) {
      print(e.toString());
      setIsLoadingOtp = false;
      return false;
    }
  }

  Future<String?> foregetPassword({required String email}) async {
    try {
      setIsLoadingOtp = true;
      var res = await _repository.foregetPassword(email: email);
      return res.fold(
        (error) {
          setIsLoadingOtp = false;
          print(error);
          showErrorMessage(null, error);
          return null;
        },
        (token) {
          setIsLoadingOtp = false;
          startTimer();
          return token;
        },
      );
    } catch (e) {
      print(e.toString());
      setIsLoadingOtp = false;
      return null;
    }
  }

  Future<bool> resendOtp({required String token}) async {
    try {
      setIsLoadingOtp = true;
      var res = await _repository.resendOtp(token: token);
      return res.fold(
        (error) {
          setIsLoadingOtp = false;
          print(error);
          showErrorMessage(null, error);
          return false;
        },
        (success) {
          setIsLoadingOtp = false;
          startTimer();
          return true;
        },
      );
    } catch (e) {
      print(e.toString());
      setIsLoadingOtp = false;
      return false;
    }
  }

  Future<bool> checkPasswordResetOtp({
    required String token,
    required String otp,
  }) async {
    try {
      setIsLoadingOtp = true;
      var res = await _repository.checkPasswordResetOtp(token: token, otp: otp);
      return res.fold(
        (error) {
          setIsLoadingOtp = false;
          print(error);
          showErrorMessage(null, error);
          return false;
        },
        (success) {
          setIsLoadingOtp = false;
          setUser = success;
          return true;
        },
      );
    } catch (e) {
      print(e.toString());
      setIsLoadingOtp = false;
      return false;
    }
  }

  Future<bool> resetPassword({required String password}) async {
    try {
      setIsLoadingOtp = true;
      var res = await _repository.resetPassword(password: password);
      return res.fold(
        (error) {
          setIsLoadingOtp = false;
          print(error);
          showErrorMessage(null, error);
          return false;
        },
        (success) {
          setIsLoadingOtp = false;
          return true;
        },
      );
    } catch (e) {
      print(e.toString());
      setIsLoadingOtp = false;
      return false;
    }
  }
}
