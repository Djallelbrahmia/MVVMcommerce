import 'package:ecommvvm/app/di.dart';
import 'package:ecommvvm/presentation/StoreDetails/store_details.dart';
import 'package:ecommvvm/presentation/forgot_password/forgot_password.dart';
import 'package:ecommvvm/presentation/login/login.dart';
import 'package:ecommvvm/presentation/main/home/home_page.dart';
import 'package:ecommvvm/presentation/main/main_view.dart';
import 'package:ecommvvm/presentation/onboarding/onboarding.dart';
import 'package:ecommvvm/presentation/register/register.dart';
import 'package:ecommvvm/presentation/ressources/string_manager.dart';
import 'package:ecommvvm/presentation/splash/splash.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onboarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/registre";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
  static const String forgetPasswordRoute = "/forgotPassword";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.forgetPasswordRoute:
        initForgetPasswordModule();
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.mainRoute:
        initHomeModule();
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case Routes.registerRoute:
        initRegisterModel();
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.storeDetailsRoute:
        initStoresDetails();

        return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(title: const Text(AppStrings.noRouteFound)),
            ));
  }
}
