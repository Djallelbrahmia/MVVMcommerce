import 'dart:async';

import 'package:ecommvvm/app/app_prefs.dart';
import 'package:ecommvvm/app/di.dart';
import 'package:ecommvvm/presentation/ressources/assets_manager.dart';
import 'package:ecommvvm/presentation/ressources/color_manager.dart';
import 'package:ecommvvm/presentation/ressources/routes_manager.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  AppPrefrences _appPrefrences = instance<AppPrefrences>();
  _startDelay() {
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }

  _goNext() async {
    _appPrefrences.getIsUserLoggedIn().then(
          (isUserLoggedIn) => {
            if (isUserLoggedIn)
              {
                Navigator.pushReplacementNamed(context, Routes.mainRoute),
              }
            else
              {
                _appPrefrences
                    .isOnBoardingScreenViewed()
                    .then((isOnBoardingScreenViewed) => {
                          if (isOnBoardingScreenViewed)
                            {
                              Navigator.pushReplacementNamed(
                                  context, Routes.loginRoute),
                            }
                          else
                            {
                              Navigator.pushReplacementNamed(
                                  context, Routes.onBoardingRoute)
                            }
                        })
              },
          },
        );
  }

  @override
  void initState() {
    _startDelay();
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body:
          const Center(child: Image(image: AssetImage(ImageAssets.splashlogo))),
    );
  }
}
