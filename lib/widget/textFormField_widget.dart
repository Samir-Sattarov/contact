import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final EdgeInsets? padding;
  final int? errorMaxLines;
  final bool? enabled;
  final bool? isPassword;
  final Color? fillColor;
  final Color? suffixIconColor;
  final Color? prefixIconColor;
  final Color? focusColor;
  final double? widthFocus;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final Widget? labelWidget;
  final String? hintText;
  final String? labelText;
  final String? suffixText;
  final String? Function(String?)? validator;
  final String? obscureChar;
  final String? prefixText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? errorStyle;
  final TextStyle? suffixTextStyle;
  final TextStyle? prefixTextStyle;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final InputBorder? focusBorder;
  final InputBorder? borderFocus;
  final InputBorder? borderDefault;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final TextInputType? keyboardType;

  const TextFormFieldWidget({
    Key? key,
    required this.controller,
    this.onChanged,
    this.padding,
    this.enabled = true,
    this.fillColor,
    this.focusColor,
    this.widthFocus,
    this.suffixIcon,
    this.prefixIcon,
    this.enabledBorder,
    this.disabledBorder,
    this.focusBorder,
    this.borderFocus,
    this.isPassword,
    this.borderDefault,
    this.errorBorder,
    this.focusedErrorBorder,
    this.hintText,
    this.labelText,
    this.hintStyle,
    this.labelStyle,
    this.errorStyle,
    this.errorMaxLines,
    this.labelWidget,
    this.keyboardType,
    this.suffixIconColor,
    this.prefixIconColor,
    this.suffixWidget,
    this.prefixWidget,
    this.suffixText,
    this.prefixText,
    this.suffixTextStyle,
    this.prefixTextStyle,
    this.obscureChar,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: TextFormField(
        validator: validator,
        enabled: enabled,
        keyboardType: keyboardType,
        obscuringCharacter: obscureChar ?? '*',
        decoration: InputDecoration(
          filled: true,
          suffixIcon: suffixIcon,
          suffix: suffixWidget,
          prefix: prefixWidget,
          prefixIcon: prefixIcon,
          prefixText: prefixText,
          suffixText: suffixText,
          prefixStyle: prefixTextStyle,
          suffixStyle: suffixTextStyle,
          prefixIconColor: prefixIconColor,
          suffixIconColor: suffixIconColor,
          fillColor: fillColor ?? const Color.fromARGB(255, 255, 255, 255),
          focusedBorder: focusBorder,
          disabledBorder: disabledBorder,
          enabledBorder: enabledBorder,
          border: borderDefault,
          errorBorder: errorBorder,
          focusedErrorBorder: focusedErrorBorder,
          labelStyle: labelStyle ?? const TextStyle(fontSize: 16),
          labelText: labelText,
          hintText: hintText,
          label: labelWidget,
          hintStyle: hintStyle ?? const TextStyle(fontSize: 16),
          errorStyle: errorStyle,
          errorMaxLines: errorMaxLines,
        ),
        controller: controller,
        onChanged: onChanged,
        obscureText: false,
      ),
    );
  }
}
