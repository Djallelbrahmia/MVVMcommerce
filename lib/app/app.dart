import 'package:easy_localization/easy_localization.dart';
import 'package:ecommvvm/app/app_prefs.dart';
import 'package:ecommvvm/app/di.dart';
import 'package:ecommvvm/presentation/ressources/routes_manager.dart';
import 'package:ecommvvm/presentation/ressources/theme_manager.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal(); //private named constructor
  static const MyApp instance = MyApp._internal(); //single instance --singleton
  factory MyApp() => instance; //factory for the class instance
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppPrefrences _appPrefrences = instance<AppPrefrences>();
  @override
  void didChangeDependencies() {
    _appPrefrences.getLocal().then((local) => context.setLocale(local));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
    );
  }
}
