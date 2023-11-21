import 'package:flutter/material.dart';

enum languageType { ENGLISH, ARABIC }

const String ARABIC = "ar";
const String ENGLISH = "en";

const Locale ARABIC_LOCAL = Locale("ar", "SA");
const Locale ENGLISH_LOCAL = Locale("en", "US");
const String ASSETS_PATH_LOCALISATIONS = "assets/json/translations";

extension languageTypeExtension on languageType {
  String getValue() {
    switch (this) {
      case languageType.ENGLISH:
        return ENGLISH;
      case languageType.ARABIC:
        return ARABIC;
    }
  }
}
