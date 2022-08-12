import 'package:flutter/material.dart';
import 'package:weight_tracker/app/constants/colors.dart';

class MyStyles {
  static RadialGradient kGradient = const RadialGradient(
    colors: [
      MyColors.kWhiteClr,
      MyColors.kLightBule,
    ],
    radius: 0.75,
    focal: Alignment(0, 0),
  );

  static TextStyle poppins({
    double fontSize = 12,
    Color color = MyColors.kBlackClr,
  }) =>
      TextStyle(
        fontFamily: 'Poppins',
        fontSize: fontSize,
        color: color,
      );

  static TextStyle poppinsSemibold({
    double fontSize = 12,
    Color color = MyColors.kBlackClr,
  }) =>
      TextStyle(
        fontFamily: 'Poppins-SemiBold',
        fontSize: fontSize,
        color: color,
      );

  static TextStyle poppinsMedium({
    double fontSize = 12,
    Color color = MyColors.kBlackClr,
  }) =>
      TextStyle(
        fontFamily: 'Poppins-Medium',
        fontSize: fontSize,
        color: color,
      );

  static TextStyle poppinsBold({
    double fontSize = 12,
    Color color = MyColors.kBlackClr,
  }) =>
      TextStyle(
        fontFamily: 'Poppins-Bold',
        fontSize: fontSize,
        color: color,
      );

  static TextStyle poppinsRegular({
    double fontSize = 12,
    Color color = MyColors.kBlackClr,
  }) =>
      TextStyle(
        fontFamily: 'Poppins-Regular',
        fontSize: fontSize,
        color: color,
      );
}
