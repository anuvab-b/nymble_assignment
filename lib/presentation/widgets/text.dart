import 'package:flutter/material.dart';
import 'package:nymble_assignment/utils/theme_styles.dart';

class CommonText extends StatelessWidget {
  final String value;
  final FontWeight? fontWeight;
  final double? fontSize;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final Color? textColor;

  const CommonText(
      {Key? key,
        this.fontWeight,
        this.fontSize,
        this.textColor,
        this.textOverflow,
        this.maxLines,
        required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(value,
        textAlign: TextAlign.center,
        maxLines: maxLines ?? 1,
        style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: fontWeight ?? FontWeight.w600,
            color: textColor ?? kTitleTextDarkColor,
            overflow: textOverflow ?? TextOverflow.ellipsis,
            fontSize: fontSize ?? 14.0
        ));
  }
}
