import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String userName, String password) = _LoginObject;
}

@freezed
class ForgetPasswordObject with _$ForgetPasswordObject {
  factory ForgetPasswordObject(String email) = _ForgetPasswordObject;
}

@freezed
class RegisterObject with _$RegisterObject {
  factory RegisterObject(
    String countryCode,
    String name,
    String email,
    String username,
    String password,
    String mobileNumber,
    String profilPicture,
  ) = _RegisterObject;
}
