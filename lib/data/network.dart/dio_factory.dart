import 'package:dio/dio.dart';
import 'package:ecommvvm/app/app_prefs.dart';
import 'package:ecommvvm/app/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const APPLICATION_JSON = "application/json";
const CONTENT_TYPE = "content-type";
const ACCEPT = "accept";
const AUTHORIZATION = "authorization";
const DEFAULT_LANGUAGE = "language";

class DioFactory {
  AppPrefrences _appPrefrences;
  DioFactory(this._appPrefrences);
  Future<Dio> getDio() async {
    Dio dio = Dio();
    const Duration _timeout = Duration(seconds: 60);
    String language = await _appPrefrences.getAppLanguage();
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: Constant.token,
      DEFAULT_LANGUAGE: language
    };
    dio.options = BaseOptions(
        baseUrl: Constant.baseUrl, connectTimeout: _timeout, headers: headers);
    if (!kReleaseMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }
    return dio;
  }
}
