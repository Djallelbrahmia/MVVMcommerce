import 'package:ecommvvm/data/network.dart/app_api.dart';
import 'package:ecommvvm/data/request/request.dart';
import 'package:ecommvvm/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(Loginrequest loginrequest);
  Future<AuthenticationResponse> register(RegisterRequest registerRequest);

  Future<ForgetPasswordResponse> forgetPassword(
      ForgetPasswordRequest forgetPasswordRequest);
  Future<HomeResponse> getHome();
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  AppServiceClient _appServiceClient;
  RemoteDataSourceImplementer(this._appServiceClient);
  @override
  Future<AuthenticationResponse> login(Loginrequest loginrequest) async {
    return await _appServiceClient.login(loginrequest.email,
        loginrequest.password, loginrequest.imei, loginrequest.deviceType);
  }

  @override
  Future<ForgetPasswordResponse> forgetPassword(
      ForgetPasswordRequest forgetPasswordRequest) async {
    return await _appServiceClient.forgetPassword(forgetPasswordRequest.email);
  }

  @override
  Future<AuthenticationResponse> register(RegisterRequest registerRequest) {
    return _appServiceClient.register(
        registerRequest.email,
        registerRequest.password,
        registerRequest.countryCode,
        registerRequest.name,
        registerRequest.username,
        registerRequest.mobileNumber,
        "");
  }

  @override
  Future<HomeResponse> getHome() async {
    return await _appServiceClient.getHome();
  }
}
