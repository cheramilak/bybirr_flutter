import 'package:bybirr_flutter/models/user_model.dart';
import 'package:bybirr_flutter/page/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  bool isLoading = false;
  final AuthProvider _authProvider;

  HomeProvider(this._authProvider);

  UserModel get user => _authProvider.getUser;

  // Example: use user data
  String get userName => "${user.firstName} ${user.lastName}";
  bool get getIsLoading => isLoading;

  bool get isKYCVerified =>
      user.kycModel != null && user.kycModel!.status == 'Approved';
  bool get isKYCFailed =>
      user.kycModel != null && user.kycModel!.status == 'Failed';
  bool get isKYCPending =>
      user.kycModel != null && user.kycModel!.status == 'Pending';
  bool get isKYCInProgress =>
      user.kycModel != null && user.kycModel!.status == 'In Progress';
  bool get isKYCNotStarted => user.kycModel == null;

  set setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
