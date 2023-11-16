import 'package:ecommvvm/presentation/ressources/font_manager.dart';
import 'package:flutter/material.dart';

TextStyle getTextStyle(
    double fontSize, FontWeight fontWeight, String fontFamily, Color color) {
  return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight);
}

// Regular Style
TextStyle getRegularStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return getTextStyle(
      fontSize, FontWightManager.regular, FontConstants.fontFamily, color);
}

//light text Style
TextStyle getlightSyle({double fontSize = FontSize.s12, required Color color}) {
  return getTextStyle(
      fontSize, FontWightManager.light, FontConstants.fontFamily, color);
}

//medium text Style
TextStyle getMediumStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return getTextStyle(
      fontSize, FontWightManager.medium, FontConstants.fontFamily, color);
}

//semi bold text Style
TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return getTextStyle(
      fontSize, FontWightManager.semiBold, FontConstants.fontFamily, color);
}

//semi bold text Style
TextStyle getBoldStyle({double fontSize = FontSize.s12, required Color color}) {
  return getTextStyle(
      fontSize, FontWightManager.bold, FontConstants.fontFamily, color);
}
