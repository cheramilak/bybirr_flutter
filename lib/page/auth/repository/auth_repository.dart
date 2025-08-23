import 'dart:io';

import 'package:bybirr_flutter/core/dio_config.dart';
import 'package:bybirr_flutter/core/endpoint.dart';
import 'package:bybirr_flutter/models/kyc.dart';
import 'package:bybirr_flutter/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nb_utils/nb_utils.dart';

class AuthRepository {
  final DioClient _dioClient = DioClient();

  Future<Either<String, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      Map<String, dynamic> data = {'email': email, 'password': password};

      var res = await _dioClient.post('${endpoint}auth/login', data: data);
      print(res);
      if (res.statusCode == 200) {
        var data = res.data['data'];
        print(data);
        String token = data['token'];
        await _dioClient.setAuthToken(token);
        UserModel user = UserModel.fromJson(data['user']);
        return Right(user);
      }
      return const Left('Someting went wrong');
    } catch (e) {
      print(e.toString());
      return Left(e.toString());
    }
  }

  Future<Either<String, UserModel>> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      Map<String, dynamic> data = {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
      };
      var res = await _dioClient.post('${endpoint}auth/signup', data: data);
      if (res.statusCode == 200) {
        var data = res.data['data'];
        print(data);
        String token = data['token'];
        await _dioClient.setAuthToken(token);
        UserModel user = UserModel.fromJson(data['user']);
        return Right(user);
      }
      return Left(errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, KYCModel>> setKYC({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String state,
    required String city,
    required String houseNumber,
    required String zipCode,
    required String line1,
    required String bod,
    required String idNumber,
    required File? idFront,
    required File? idBack,
    required File? photo,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phone': phone,
        'city': city,
        'address': state,
        'houseNumber': houseNumber,
        'zipCode': zipCode,
        'line1': line1,
        'bod': bod,
        'idNumber': idNumber,
        'photo': await MultipartFile.fromFile(
          photo!.path,
          filename: photo.path.split('/').last,
        ),
        'idFront': await MultipartFile.fromFile(
          idFront!.path,
          filename: idFront.path.split('/').last,
        ),
        'idBack': await MultipartFile.fromFile(
          idBack!.path,
          filename: idBack.path.split('/').last,
        ),
      });
      var res = await _dioClient.post('${endpoint}set-kyc', data: formData);
      if (res.statusCode == 200) {
        var data = res.data['data'];
        KYCModel kycModel = KYCModel.fromJson(data['kyc']);
        return Right(kycModel);
      }
      return Left(errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, UserModel>> getUserProfile() async {
    try {
      var res = await _dioClient.get('${endpoint}auth/getUserProfile');
      if (res.statusCode == 200) {
        var data = res.data['data'];
        print(data);
        UserModel user = UserModel.fromJson(data['user']);
        return Right(user);
      }
      return Left(errorMessage);
    } catch (e) {
      print(e.toString());
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> emailVerification() async {
    try {
      var res = await _dioClient.get('${endpoint}auth/emailVerification');
      print(res);
      if (res.statusCode == 200) {
        var data = res.data['data'];
        print(data);
        return Right('success');
      }
      return Left(errorMessage);
    } catch (e) {
      print(e.toString());
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> verifyOtp({required String otp}) async {
    try {
      var res = await _dioClient.post(
        '${endpoint}auth/checkOtp',
        data: {'code': otp},
      );
      if (res.statusCode == 200) {
        return Right('success');
      }
      return Left(errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> logout() async {
    try {
      var res = await _dioClient.post('${endpoint}auth/logout');
      if (res.statusCode == 200) {
        return Right('success');
      }
      return Left(errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> foregetPassword({
    required String email,
  }) async {
    try {
      var res = await _dioClient.post(
        '${endpoint}auth/forgetPassword',
        data: {'email': email},
      );
      if (res.statusCode == 200) {
        var data = res.data['data'];
        print(data);

        return Right(data['token']);
      }
      return Left(errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> resendOtp({required String token}) async {
    try {
      var res = await _dioClient.post(
        '${endpoint}auth/resendPasswordResetOtp',
        data: {'token': token},
      );
      if (res.statusCode == 200) {
        print(res.data);
        return Right(true);
      }
      return Left(errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, UserModel>> checkPasswordResetOtp({
    required String token,
    required String otp,
  }) async {
    try {
      var res = await _dioClient.post(
        '${endpoint}auth/checkPasswordResetOtp',
        data: {'token': token, 'code': otp},
      );
      if (res.statusCode == 200) {
        var data = res.data['data'];
        print(data);
        UserModel user = UserModel.fromJson(data['user']);
        await _dioClient.setAuthToken(data['token']);
        return Right(user);
      }
      return Left(errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> resetPassword({required String password}) async {
    try {
      var res = await _dioClient.post(
        '${endpoint}auth/resetPassword',
        data: {'password': password},
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
