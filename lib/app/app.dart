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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
    );
  }
}
