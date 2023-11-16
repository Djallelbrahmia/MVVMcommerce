import 'dart:async';

import 'package:ecommvvm/domain/use_cases/forget_password.dart';
import 'package:ecommvvm/presentation/common/freezed_data.dart';
import 'package:ecommvvm/presentation/base/baseviewmodel.dart';
import 'package:ecommvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:ecommvvm/presentation/common/state_renderer/state_rendrer_impl.dart';

class ForgetPasswordViewModel extends BaseViewModel
    with ForgetPasswordViewModelInputs, ForgetPasswordViewModelOutputs {
  StreamController _emailStreamController =
      StreamController<String>.broadcast();
  var forgetPasswordObject = ForgetPasswordObject("");
  bool _isEmail(String email) {
    return email.isNotEmpty && email.contains('@');
  }

  ForgetPasswordUseCase _forgetPasswordUseCase;
  ForgetPasswordViewModel(this._forgetPasswordUseCase);

  @override
  forgetPassword() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _forgetPasswordUseCase
            .execute(ForgetPasswordUseCaseInput(forgetPasswordObject.email)))
        .fold((failure) {
      print(failure.message);
      inputState.add(
          ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
    }, (data) {
      inputState.add(SuccessState(data.support));
    });
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Stream<bool> get outpuEmailisValid =>
      _emailStreamController.stream.map((email) => _isEmail(email));

  @override
  setEmail(String email) {
    forgetPasswordObject = forgetPasswordObject.copyWith(email: email);
    _emailStreamController.add(email);
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _emailStreamController.close();
  }
}

mixin ForgetPasswordViewModelInputs {
  //three functions
  setEmail(String email);
  forgetPassword();
  //sinks
  Sink get inputEmail;
}
mixin ForgetPasswordViewModelOutputs {
  Stream<bool> get outpuEmailisValid;
}
