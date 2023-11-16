import 'dart:async';

import 'package:ecommvvm/presentation/common/state_renderer/state_rendrer_impl.dart';

abstract class BaseViewModel with BaseViewModelInputs, BaseViewModelOutputs {
  StreamController _inputStateController =
      StreamController<FlowState>.broadcast();
  @override
  Sink get inputState => _inputStateController.sink;
  @override
  Stream<FlowState> get outPutState =>
      _inputStateController.stream.map((flowState) => flowState);
  @override
  void dispose() {
    _inputStateController.close();
  }
}

mixin BaseViewModelInputs {
  void start(); //will be called while init of view model
  void dispose(); //will be called when viewmodel dies
  Sink get inputState;
}

mixin BaseViewModelOutputs {
  Stream<FlowState> get outPutState;
}
