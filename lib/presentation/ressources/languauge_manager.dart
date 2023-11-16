enum languageType { ENGLISH, ARABIC }

const String ARABIC = "ar";
const String ENGLISH = "en";

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
