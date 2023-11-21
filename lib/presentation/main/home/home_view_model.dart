import 'dart:async';
import 'dart:ffi';

import 'package:ecommvvm/domain/use_cases/home_use_case.dart';
import 'package:ecommvvm/presentation/base/baseviewmodel.dart';

import 'package:ecommvvm/domain/model/model.dart';
import 'package:ecommvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:ecommvvm/presentation/common/state_renderer/state_rendrer_impl.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInputs, HomeViewModelOutputs {
  HomeUseCase _homeUseCase;

  StreamController _bannersStreamController = BehaviorSubject<List<Banners>>();
  StreamController _servicesStreamController =
      BehaviorSubject<List<Services>>();
  StreamController _storesStreamController = BehaviorSubject<List<Stores>>();

  HomeViewModel(this._homeUseCase);

  // inputs
  @override
  void start() {
    _getHome();
  }

  _getHome() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));
    (await _homeUseCase.execute(Void)).fold((failure) {
      inputState.add(ErrorState(
          StateRendererType.FULL_SCREEN_ERROR_STATE, failure.message));
    }, (homeObject) {
      inputState.add(ContentState());
      inputBanners.add(homeObject.data.banners);
      inputServices.add(homeObject.data.services);
      inputStores.add(homeObject.data.stores);
    });
  }

  @override
  void dispose() {
    _bannersStreamController.close();
    _servicesStreamController.close();
    _storesStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputBanners => _bannersStreamController.sink;

  @override
  Sink get inputServices => _servicesStreamController.sink;

  @override
  Sink get inputStores => _storesStreamController.sink;

  // outputs
  @override
  Stream<List<Banners>> get outputBanners =>
      _bannersStreamController.stream.map((banners) => banners);

  @override
  Stream<List<Services>> get outputServices =>
      _servicesStreamController.stream.map((services) => services);

  @override
  Stream<List<Stores>> get outputStores =>
      _storesStreamController.stream.map((stores) => stores);
}

mixin HomeViewModelInputs {
  Sink get inputStores;

  Sink get inputServices;

  Sink get inputBanners;
}

mixin HomeViewModelOutputs {
  Stream<List<Stores>> get outputStores;

  Stream<List<Services>> get outputServices;

  Stream<List<Banners>> get outputBanners;
}
