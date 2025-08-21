import 'dart:io';

import 'package:bybirr_flutter/core/exception_message.dart';
import 'package:bybirr_flutter/models/bank_model.dart';
import 'package:bybirr_flutter/models/rate_model.dart';
import 'package:bybirr_flutter/page/card/repository/card_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class CardProvider extends ChangeNotifier {
  CardRepository _repository = CardRepository();
  RateModel? rateModel;
  int selectBankIndex = -1;
  List<BankModel> bankList = [];

  bool isLoadingPayment = false;
  bool get getLoadingPayment => isLoadingPayment;
  RateModel? get getRate => rateModel;
  List<BankModel> get getBankList => bankList;
  File? screenshoot;
  File? get getScreenshoot => screenshoot;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickScreensoot() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        screenshoot = File(pickedFile.path);
        notifyListeners();
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  set setLoadingPayment(bool value) {
    isLoadingPayment = value;
    notifyListeners();
  }

  set setRate(RateModel? value) {
    rateModel = value;
    notifyListeners();
  }

  set setBankList(List<BankModel> value) {
    bankList = value;
    notifyListeners();
  }

  set setSelectedBank(int value) {
    selectBankIndex = value;
    notifyListeners();
  }

  Future fatchRate() async {
    try {
      setRate = null;
      selectBankIndex = -1;
      var res = await _repository.fatchRate();
      res.fold(
        (l) {
          showErrorMessage(null, l);
        },
        (r) {
          setRate = RateModel.fromJson(r['rate']);
          var list = r['banks'] as List;
          setBankList = list.map((e) => BankModel.fromJson(e)).toList();
        },
      );
    } catch (e) {
      showErrorMessage(null, e.toString());
    }
  }

  Future<bool> orderCard({
    required String amount,
    required String transactionId,
    required int bankId,
  }) async {
    if (isLoadingPayment) return false;
    try {
      setLoadingPayment = true;
      var res = await _repository.ordercard(
        amount: amount,
        rate: getRate!.rate,
        transactionRef: transactionId,
        bankId: bankId,
        photo: screenshoot,
      );
      return res.fold(
        (l) {
          setLoadingPayment = false;
          showErrorMessage(null, l);
          return false;
        },
        (r) {
          setLoadingPayment = false;
          return true;
        },
      );
    } catch (e) {
      showErrorMessage(null, e.toString());
      setLoadingPayment = false;
      return false;
    }
  }
}
