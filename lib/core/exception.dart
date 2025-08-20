import 'package:dio/dio.dart';

String handleDioError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return "Timeout occurred while sending or receiving";
    case DioExceptionType.badResponse:
      final statusCode = error.response?.statusCode;
      if (statusCode != null) {
        switch (statusCode) {
          case 400:
            // Check if 'message' exists in the response data
            if (error.response?.data is Map &&
                error.response!.data.containsKey('message')) {
              return error.response!.data['message'];
            }
            return "Bad Request";
          case 401:
          case 403:
            return "Unauthorized";
          case 404:
            return "Not Found";
          case 409:
            return 'Conflict';
          case 500:
            return "Internal Server Error";
          default:
            return "Something went wrong please try again later";
        }
      }
      break;
    case DioExceptionType.cancel:
      return "Request was cancelled";
    case DioExceptionType.unknown:
      return "Unknown Error";
    case DioExceptionType.badCertificate:
      return "Bad Certificate";
    case DioExceptionType.connectionError:
      return "Connection Error, please check your connection!";
    default:
      return "Unknown Error";
  }
  return "Unknown Error";
}
