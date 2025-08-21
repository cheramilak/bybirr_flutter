import 'dart:io';

import 'package:bybirr_flutter/core/dio_config.dart';
import 'package:bybirr_flutter/core/endpoint.dart';
import 'package:bybirr_flutter/models/virtual_card_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nb_utils/nb_utils.dart';

class CardRepository {
  final DioClient _dioClient = DioClient();

  Future<Either<String, dynamic>> fatchRate() async {
    try {
      var res = await _dioClient.get('${endpoint}card/getCurrentRate');
      if (res.statusCode == 200) {
        var data = res.data['data'];
        return Right(data);
      }
      return Left(errorMessage);
    } catch (e) {
      print(e.toString());
      return Left(e.toString());
    }
  }

  Future<Either<String, List<VirtualCardModel>>> fatchCards() async {
    try {
      var res = await _dioClient.get('${endpoint}card/getCards');
      if (res.statusCode == 200) {
        var data = res.data['data'];
        var list = data['cards'] as List;
        List<VirtualCardModel> cards = list
            .map((e) => VirtualCardModel.fromJson(e))
            .toList();
        return Right(cards);
      }
      return Left(errorMessage);
    } catch (e) {
      print(e.toString());
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> ordercard({
    required String amount,
    required double rate,
    required String transactionRef,
    required int bankId,
    required File? photo,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'amount': amount,
        'rate': rate,
        'bankId': bankId,
        'transactionId': transactionRef,
        'image': await MultipartFile.fromFile(
          photo!.path,
          filename: photo.path.split('/').last,
        ),
      });
      var res = await _dioClient.post(
        '${endpoint}card/order-card',
        data: formData,
      );
      if (res.statusCode == 200) {
        return Right(true);
      }
      return Left(errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
