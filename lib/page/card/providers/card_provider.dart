import 'dart:io';

import 'package:bybirr_flutter/core/exception_message.dart';
import 'package:bybirr_flutter/models/bank_model.dart';
import 'package:bybirr_flutter/models/rate_model.dart';
import 'package:bybirr_flutter/models/virtual_card_model.dart';
import 'package:bybirr_flutter/models/transaction_model.dart';
import 'package:bybirr_flutter/page/card/repository/card_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class CardProvider extends ChangeNotifier {
  CardRepository _repository = CardRepository();
  VirtualCardModel? virtualCardModel;
  RateModel? rateModel;
  int selectBankIndex = -1;
  List<BankModel> bankList = [];
  List<VirtualCardModel> virtualCardList = [];
  List<TransactionModel> transactionList = [];

  VirtualCardModel? get getVirtualCardModel => virtualCardModel;

  List<VirtualCardModel> get getCards => virtualCardList;

  bool isLoadingPayment = false;
  bool isLoadingTransactions = false;
  bool get getLoadingPayment => isLoadingPayment;
  bool isLoadingCards = false;
  bool isVissableBalance = false;
  bool get getLoadingCards => isLoadingCards;
  RateModel? get getRate => rateModel;
  List<BankModel> get getBankList => bankList;
  File? screenshoot;
  File? get getScreenshoot => screenshoot;
  bool get getLoadingTransactions => isLoadingTransactions;
  List<TransactionModel> get getTransactionList => transactionList;
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

  set setLoadingTransactions(bool value) {
    isLoadingTransactions = value;
    notifyListeners();
  }

  set setTransactionList(List<TransactionModel> value) {
    transactionList = value;
    notifyListeners();
  }

  set setLoadingCards(bool value) {
    isLoadingCards = value;
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

  toogleBalanceVissable() {
    isVissableBalance = !isVissableBalance;
    notifyListeners();
  }

  set setcardList(List<VirtualCardModel> value) {
    virtualCardList = value;
    notifyListeners();
  }

  set setVirtualCardModel(VirtualCardModel? value) {
    virtualCardModel = value;
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

  Future fatchCards() async {
    try {
      setLoadingPayment = true;
      var res = await _repository.fatchCards();
      res.fold(
        (l) {
          setLoadingPayment = false;
          showErrorMessage(null, l);
        },
        (r) {
          setLoadingPayment = false;
          setcardList = r;
        },
      );
    } catch (e) {
      setLoadingPayment = false;
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

  Future<void> fatchCardDetail(String cardId) async {
    try {
      // if (getVirtualCardModel != null) {
      //   if (getVirtualCardModel!.id == cardId) {
      //     return;
      //   }
      // }
      setVirtualCardModel = null;
      var res = await _repository.fatchCardDetail(cardId);
      res.fold(
        (l) {
          showErrorMessage(null, l);
        },
        (r) {
          setVirtualCardModel = r;
          fatchTransactions(cardId);
        },
      );
    } catch (e) {
      showErrorMessage(null, e.toString());
    }
  }

  Future<void> fatchTransactions(String cardId) async {
    try {
      setLoadingTransactions = true;
      var res = await _repository.fatchTransactions(cardId);
      res.fold(
        (l) {
          setLoadingTransactions = false;
          showErrorMessage(null, l);
        },
        (r) {
          setLoadingTransactions = false;
          setTransactionList = r;
        },
      );
    } catch (e) {
      setLoadingTransactions = false;
      showErrorMessage(null, e.toString());
    }
  }
}
