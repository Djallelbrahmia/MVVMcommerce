import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:ecommvvm/domain/model/model.dart';
import 'package:ecommvvm/presentation/base/baseviewmodel.dart';
import 'package:ecommvvm/presentation/ressources/assets_manager.dart';
import 'package:ecommvvm/presentation/ressources/string_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  final StreamController _streamController =
      StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int _currentIndex = 0;
  //private functions
  List<SliderObject> _getSliderData() => [
        SliderObject(
            AppStrings.onBoardingTitle1.tr(),
            AppStrings.onBoardingSubTitle1.tr(),
            ImageAssets.onBoardingImage1.tr()),
        SliderObject(
            AppStrings.onBoardingTitle2.tr(),
            AppStrings.onBoardingSubTitle2.tr(),
            ImageAssets.onBoardingImage2.tr()),
        SliderObject(
            AppStrings.onBoardingTitle3.tr(),
            AppStrings.onBoardingSubTitle3.tr(),
            ImageAssets.onBoardingImage3.tr()),
        SliderObject(
            AppStrings.onBoardingTitle4.tr(),
            AppStrings.onBoardingSubTitle4.tr(),
            ImageAssets.onBoardingImage4.tr())
      ];
  _postDataToView() {
    inputSliderViewObject.add(
        SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    //send this slider data to our view
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = _currentIndex++;
    if (nextIndex >= _list.length - 1) {
      _currentIndex = 0;
    }
    return _currentIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = _currentIndex--;
    if (previousIndex == -1) {
      _currentIndex = _list.length - 1;
    }
    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderObject) => sliderObject);
}

mixin OnBoardingViewModelInputs {
  void goNext();
  void goPrevious();
  void onPageChanged(int index);
  Sink get inputSliderViewObject; // this is the wa
}

mixin OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;
  SliderViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}
