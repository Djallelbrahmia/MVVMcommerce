import 'package:dio/dio.dart';
import 'package:ecommvvm/data/network.dart/failure.dart';

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  UNKNOWN,
  DEFAULT
}

class ErrorHandler implements Exception {
  late Failure failure;
  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      failure = _handleError(error);
    } else {
      failure = DataSource.DEFAULT.getFailure();
    }
  }
  Failure _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return DataSource.CONNECT_TIMEOUT.getFailure();
      case DioExceptionType.sendTimeout:
        return DataSource.SEND_TIMEOUT.getFailure();
      case DioExceptionType.receiveTimeout:
        return DataSource.RECEIVE_TIMEOUT.getFailure();
      case DioExceptionType.badCertificate:
        return DataSource.UNAUTHORISED.getFailure();
      case DioExceptionType.badResponse:
        return DataSource.FORBIDDEN.getFailure();
      case DioExceptionType.cancel:
        return DataSource.CANCEL.getFailure();
      case DioExceptionType.connectionError:
        return DataSource.INTERNAL_SERVER_ERROR.getFailure();

      case DioExceptionType.unknown:
        return DataSource.UNKNOWN.getFailure();
    }
  }
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponsMessage.BAD_REQUEST);
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponsMessage.FORBIDDEN);
      case DataSource.UNAUTHORISED:
        return Failure(ResponseCode.UNAUTHORISED, ResponsMessage.UNAUTHORISED);
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponsMessage.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponsMessage.INTERNAL_SERVER_ERROR);

      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            ResponseCode.CONNECT_TIMEOUT, ResponsMessage.CONNECT_TIMEOUT);
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponsMessage.CANCEL);
      case DataSource.RECEIVE_TIMEOUT:
        return Failure(
            ResponseCode.RECEIVE_TIMEOUT, ResponsMessage.RECEIVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponsMessage.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponsMessage.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponsMessage.NO_INTERNET_CONNECTION);
      case DataSource.UNKNOWN:
        return Failure(ResponseCode.UNKNOWN, ResponsMessage.UNKNOWN);
      case DataSource.DEFAULT:
        return Failure(ResponseCode.UNKNOWN, ResponsMessage.UNKNOWN);
      default:
        return Failure(ResponseCode.BAD_REQUEST, ResponsMessage.BAD_REQUEST);
    }
  }
}

class ResponseCode {
  //  API status codes
  static const int SUCCESS = 200;
  static const int NO_CONTENT = 201;
  static const int BAD_REQUEST = 400;
  static const int FORBIDDEN = 403;
  static const int UNAUTHORISED = 401;
  static const int NOT_FOUND = 404;
  static const int INTERNAL_SERVER_ERROR = 500;
  //local status code
  static const int UNKNOWN = -1;

  static const int CONNECT_TIMEOUT = -2;
  static const int CANCEL = -3;
  static const int RECEIVE_TIMEOUT = -4;
  static const int SEND_TIMEOUT = -5;
  static const int CACHE_ERROR = -6;
  static const int NO_INTERNET_CONNECTION = -7;
}

class ResponsMessage {
  //  API status codes
  static const String SUCCESS = "succes";
  static const String NO_CONTENT = "sucess with no content";
  static const String BAD_REQUEST = "Bad request , try again later";
  static const String FORBIDDEN = "forbidden request , try again later";
  static const String UNAUTHORISED = "user is unauthorised , try again later";
  static const String NOT_FOUND = "user is not found ";
  static const String INTERNAL_SERVER_ERROR =
      "some thing went wrong , try again later ";
  //local status code
  static const String UNKNOWN = "some thing went wrong , try again later";

  static const String CONNECT_TIMEOUT = "timeout, try again later";
  static const String CANCEL = "request was cancelled , try again later";
  static const String RECEIVE_TIMEOUT = "timeout, try again later";
  static const String SEND_TIMEOUT = "timeout, try again later";
  static const String CACHE_ERROR = "cache error , try again later ";
  static const String NO_INTERNET_CONNECTION =
      "please check your internet connection and try again later, try again later";
}
