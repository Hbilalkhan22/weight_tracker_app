// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:weight_tracker/app/constants/colors.dart';
import 'package:weight_tracker/app/constants/styles.dart';

class CapsoleContainer extends StatelessWidget {
  CapsoleContainer({
    this.w,
    this.h,
    this.color,
    this.child,
    this.radius = 10,
    this.text,
    Key? key,
  }) : super(key: key);
  double? h, w;
  double radius;
  Color? color;
  Widget? child;
  String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: h,
      width: w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius), color: color),
      child: child ?? textWidget(),
    );
  }

  Center textWidget() => Center(
        child: Text(
          text ?? '',
          // textAlign: TextAlign.center,
          style: MyStyles.poppinsSemibold(color: MyColors.kWhiteClr),
        ),
      );
}
