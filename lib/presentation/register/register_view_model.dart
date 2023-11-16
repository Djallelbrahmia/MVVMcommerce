import 'dart:async';
import 'dart:io';
import 'package:ecommvvm/domain/use_cases/register_use_case.dart';
import 'package:ecommvvm/presentation/base/baseviewmodel.dart';
import 'package:ecommvvm/presentation/common/freezed_data.dart';
import 'package:ecommvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:ecommvvm/presentation/common/state_renderer/state_rendrer_impl.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInput, RegisterViewModelOutput {
  StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  StreamController _mobileNumberStreamController =
      StreamController<String>.broadcast();

  StreamController _emailStreamController =
      StreamController<String>.broadcast();

  StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  StreamController _profilePictureStreamController =
      StreamController<File>.broadcast();

  StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();

  StreamController isUserLoggedInSuccessfullyStreamController =
      StreamController<bool>();

  RegisterUseCase _registerUseCase;

  var registerViewObject = RegisterObject("", "", "", "", "", "", "");

  RegisterViewModel(this._registerUseCase);
  isEmailValid(String email) {
    return email.contains("@");
  }

  //  -- inputs
  @override
  void start() {
    // view tells state renderer, please show the content of the screen
    inputState.add(ContentState());
  }

  @override
  register() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _registerUseCase.execute(RegisterUseCaseInput(
            registerViewObject.countryCode,
            registerViewObject.name,
            registerViewObject.email,
            registerViewObject.username,
            registerViewObject.password,
            registerViewObject.mobileNumber,
            registerViewObject.profilPicture)))
        .fold(
            (failure) => {
                  // left -> failure
                  inputState.add(ErrorState(
                      StateRendererType.POPUP_ERROR_STATE, failure.message))
                }, (data) {
      // right -> success (data)
      inputState.add(ContentState());

      // navigate to main screen after the login
      isUserLoggedInSuccessfullyStreamController.add(true);
    });
  }

  @override
  void dispose() {
    _isAllInputsValidStreamController.close();
    _userNameStreamController.close();
    _mobileNumberStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _profilePictureStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();
    super.dispose();
  }

  @override
  setCountryCode(String countryCode) {
    if (countryCode.isNotEmpty) {
      // update register view object with countryCode value
      registerViewObject = registerViewObject.copyWith(
          countryCode: countryCode); // using data class like kotlin
    } else {
      // reset countryCode value in register view object
      registerViewObject = registerViewObject.copyWith(countryCode: "");
    }
    _validate();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (isEmailValid(email)) {
      // update register view object with email value
      registerViewObject = registerViewObject.copyWith(
          email: email); // using data class like kotlin
    } else {
      // reset email value in register view object
      registerViewObject = registerViewObject.copyWith(email: "");
    }
    _validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputMobileNumber.add(mobileNumber);
    if (_isMobileNumberValid(mobileNumber)) {
      // update register view object with mobileNumber value
      registerViewObject = registerViewObject.copyWith(
          mobileNumber: mobileNumber); // using data class like kotlin
    } else {
      // reset mobileNumber value in register view object
      registerViewObject = registerViewObject.copyWith(mobileNumber: "");
    }
    _validate();
  }

  @override
  setPassword(String password) {
    inputUPassword.add(password);
    if (_isPasswordValid(password)) {
      // update register view object with password value
      registerViewObject = registerViewObject.copyWith(
          password: password); // using data class like kotlin
    } else {
      // reset password value in register view object
      registerViewObject = registerViewObject.copyWith(password: "");
    }
    _validate();
  }

  @override
  setProfilePicture(File file) {
    inputProfilePicture.add(file);
    if (file.path.isNotEmpty) {
      // update register view object with profilePicture value
      registerViewObject = registerViewObject.copyWith(
          profilPicture: file.path); // using data class like kotlin
    } else {
      // reset profilePicture value in register view object
      registerViewObject = registerViewObject.copyWith(profilPicture: "");
    }
    _validate();
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    if (_isUserNameValid(userName)) {
      // update register view object with username value
      registerViewObject = registerViewObject.copyWith(
          username: userName); // using data class like kotlin
    } else {
      // reset username value in register view object
      registerViewObject = registerViewObject.copyWith(username: "");
    }
    _validate();
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputMobileNumber => _mobileNumberStreamController.sink;

  @override
  Sink get inputProfilePicture => _profilePictureStreamController.sink;

  @override
  Sink get inputUPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputAllInputsValid => _isAllInputsValidStreamController.sink;

  // -- outputs

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _validateAllInputs());

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<String?> get outputErrorUserName => outputIsUserNameValid
      .map((isUserNameValid) => isUserNameValid ? null : "Invalid username");

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<String?> get outputErrorEmail => outputIsEmailValid
      .map((isEmailValid) => isEmailValid ? null : "Invalid Email");

  @override
  Stream<bool> get outputIsMobileNumberValid =>
      _mobileNumberStreamController.stream
          .map((mobileNumber) => _isMobileNumberValid(mobileNumber));

  @override
  Stream<String?> get outputErrorMobileNumber =>
      outputIsMobileNumberValid.map((isMobileNumberValid) =>
          isMobileNumberValid ? null : "Invalid Mobile Number");

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<String?> get outputErrorPassword => outputIsPasswordValid
      .map((isPasswordValid) => isPasswordValid ? null : "Invalid Password");

  @override
  Stream<File?> get outputProfilePicture =>
      _profilePictureStreamController.stream.map((file) => file);

  // -- private methods
  bool _isUserNameValid(String userName) {
    return userName.length >= 8;
  }

  bool _isMobileNumberValid(String mobileNumber) {
    return mobileNumber.length >= 10;
  }

  bool _isPasswordValid(String password) {
    return password.length >= 8;
  }

  bool _validateAllInputs() {
    return registerViewObject.profilPicture.isNotEmpty &&
        registerViewObject.email.isNotEmpty &&
        registerViewObject.password.isNotEmpty &&
        registerViewObject.mobileNumber.isNotEmpty &&
        registerViewObject.username.isNotEmpty &&
        registerViewObject.countryCode.isNotEmpty;
  }

  _validate() {
    inputAllInputsValid.add(null);
  }
}

mixin RegisterViewModelInput {
  register();

  setUserName(String userName);

  setMobileNumber(String mobileNumber);

  setCountryCode(String countryCode);

  setEmail(String email);

  setPassword(String password);

  setProfilePicture(File file);

  Sink get inputUserName;

  Sink get inputMobileNumber;

  Sink get inputEmail;

  Sink get inputUPassword;

  Sink get inputProfilePicture;

  Sink get inputAllInputsValid;
}

mixin RegisterViewModelOutput {
  Stream<bool> get outputIsUserNameValid;

  Stream<String?> get outputErrorUserName;

  Stream<bool> get outputIsMobileNumberValid;

  Stream<String?> get outputErrorMobileNumber;

  Stream<bool> get outputIsEmailValid;

  Stream<String?> get outputErrorEmail;

  Stream<bool> get outputIsPasswordValid;

  Stream<String?> get outputErrorPassword;

  Stream<File?> get outputProfilePicture;

  Stream<bool> get outputIsAllInputsValid;
}
