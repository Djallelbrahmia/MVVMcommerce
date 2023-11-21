import 'package:easy_localization/easy_localization.dart';
import 'package:ecommvvm/app/app.dart';
import 'package:ecommvvm/app/di.dart';
import 'package:ecommvvm/presentation/ressources/languauge_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(EasyLocalization(
      child: Phoenix(child: MyApp()),
      supportedLocales: [ENGLISH_LOCAL, ARABIC_LOCAL],
      path: ASSETS_PATH_LOCALISATIONS));
}
