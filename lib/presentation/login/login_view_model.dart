import 'dart:async';

import 'package:ecommvvm/domain/use_cases/login_use_case.dart';
import 'package:ecommvvm/presentation/base/baseviewmodel.dart';
import 'package:ecommvvm/presentation/common/freezed_data.dart';
import 'package:ecommvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:ecommvvm/presentation/common/state_renderer/state_rendrer_impl.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();
  StreamController isUserLoggedInSuccessfullyStreamController =
      StreamController<bool>();
  var loginObject = LoginObject("", "");
  LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);
  //Private functions
  bool _isUserNameValid(String username) {
    return username.isNotEmpty;
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isAllInputValid() {
    return _isPasswordValid(loginObject.password) &&
        _isUserNameValid(loginObject.userName);
  }

  @override
  void dispose() {
    _passwordStreamController.close();
    _userNameStreamController.close();
    _isAllInputsValidStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  login() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _loginUseCase.execute(
            LoginUseCaseInput(loginObject.userName, loginObject.password)))
        .fold(
      (failure) => {
        inputState.add(
            ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message)),
      },
      (data) => {
        inputState.add(
          ContentState(),
        ),
        isUserLoggedInSuccessfullyStreamController.add(true)
      },
    );
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    _isAllInputsValidStreamController.add(null);
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
    _isAllInputsValidStreamController.add(null);
  }

  @override
  Sink get InputIsAllInput => throw UnimplementedError();
  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((username) => _isUserNameValid(username));

  @override
  Stream<bool> get outputPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputisAllInputValid =>
      _isAllInputsValidStreamController.stream.map((_) => _isAllInputValid());
}

mixin LoginViewModelInputs {
  //three functions
  setUserName(String userName);
  setPassword(String password);
  login();
  //two sinks
  Sink get inputUserName;
  Sink get inputPassword;
  Sink get InputIsAllInput;
}
mixin LoginViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputPasswordValid;
  Stream<bool> get outputisAllInputValid;
}
