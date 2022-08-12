import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weight_tracker/app/constants/colors.dart';
import 'package:weight_tracker/app/constants/styles.dart';

class MTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final bool obsecure;
  final bool readOnly;
  final VoidCallback? onTap;
  final VoidCallback? onEditingCompleted;
  final ValueChanged<String>? onFormSubmit;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final bool isMulti;
  final bool autofocus;
  final bool enabled;
  final String? errorText;
  final String? label;
  final Widget? suffix;
  final Widget? prefix;
  final TextAlign textAlign;
  final double height;
  final int tfLines;
  final int? inputLength;

  const MTextField(
      {Key? key,
      this.controller,
      this.validator,
      this.keyboardType = TextInputType.text,
      this.obsecure = false,
      this.onTap,
      this.isMulti = false,
      this.readOnly = false,
      this.autofocus = false,
      this.errorText,
      @required this.label,
      this.suffix,
      this.prefix,
      this.textAlign = TextAlign.left,
      this.enabled = true,
      this.onEditingCompleted,
      this.onFormSubmit,
      this.height = 50,
      this.tfLines = 1,
      this.inputLength,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   height: height,
    //   width: double.infinity,
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(5),
    //     color: MyColors.greyColor,
    //     // border: Border.all(color: MyColors.greenish)),
    //   ),
    return TextFormField(
        onChanged: onChanged,
        onEditingComplete: onEditingCompleted,
        onFieldSubmitted: onFormSubmit,
        autofocus: autofocus,
        minLines: isMulti ? 4 : 1,
        maxLines: tfLines, //isMulti ? 6 : 1,
        onTap: onTap,
        // cursorHeight: height,
        enabled: enabled,
        readOnly: readOnly,
        obscureText: obsecure,
        keyboardType: keyboardType,
        controller: controller,
        textAlign: textAlign,
        inputFormatters: [
          LengthLimitingTextInputFormatter(inputLength),
        ],
        decoration: InputDecoration(
          filled: true,
          fillColor: MyColors.kWhiteClr,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide.none,
          ),
          errorBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10)),
          errorText: errorText,
          prefixIcon: prefix,
          suffixIcon: suffix,
          // labelStyle: TextStyle(),
          // labelText: label,

          suffixIconConstraints: const BoxConstraints(
            minWidth: 2,
            minHeight: 2,
          ),
          hintText: label,
          hintStyle: MyStyles.poppinsRegular(fontSize: 13),
          contentPadding:
              const EdgeInsets.only(left: 15, right: 15, top: 13, bottom: 13),
          // enabledBorder: InputBorder.none,
          // disabledBorder: InputBorder.none,
          // focusedBorder: InputBorder.none,
        ),
        validator: validator
        // ),
        );
  }
}
