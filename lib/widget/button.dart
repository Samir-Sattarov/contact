import 'package:flutter/material.dart';

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
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        height: height ?? 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.amber.withOpacity(0.5),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.green,
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
