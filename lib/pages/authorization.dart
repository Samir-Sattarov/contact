import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';

class Authorization extends StatelessWidget {
  Authorization({Key? key}) : super(key: key);

  final TextEditingController _controllerLogin = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff274472),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Plese login to your account',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 28,
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextFieldWidget(
            prefixIcon: const Icon(Icons.email),
            hintText: 'Email',
            padding: const EdgeInsets.symmetric(horizontal: 10),
            controller: _controllerLogin,
            focusBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.blue.shade100,
                width: 3,
              ),
            ),
            borderDefault: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 20),
          TextFieldWidget(
            prefixIcon: const Icon(Icons.lock),
            hintText: 'Password',
            padding: const EdgeInsets.symmetric(horizontal: 10),
            controller: _controllerPassword,
            focusBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.blue.shade100,
                width: 3,
              ),
            ),
            borderDefault: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 20),
          ButtonWidget(
            text: 'Confirm',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final EdgeInsets? padding;
  final String text;
  final TextStyle? textStyle;
  final double? width;
  final double? height;
  final Function() onTap;
  final BorderRadius? borderRadius;
  const ButtonWidget({
    Key? key,
    this.padding,
    required this.text,
    this.width,
    this.height,
    this.textStyle,
    required this.onTap,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: width ?? MediaQuery.of(context).size.width,
        height: height ?? 52,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.amber,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: onTap,
          child: Text(
            text,
            style: textStyle ?? const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
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

  const TextFieldWidget({
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: TextField(
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
