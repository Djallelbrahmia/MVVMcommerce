class Loginrequest {
  String email;
  String password;
  String imei;
  String deviceType;
  Loginrequest(this.email, this.password, this.imei, this.deviceType);
}

class ForgetPasswordRequest {
  String email;
  ForgetPasswordRequest(this.email);
}

class RegisterRequest {
  String countryCode;
  String name;
  String email;
  String username;
  String password;
  String mobileNumber;
  String profilPicture;
  RegisterRequest(this.countryCode, this.name, this.email, this.username,
      this.password, this.mobileNumber, this.profilPicture);
}

