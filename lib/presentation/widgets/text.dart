import 'package:flutter/material.dart';
import 'package:nymble_assignment/utils/colour_utils.dart';

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
        maxLines: maxLines ?? 1,
        style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: fontWeight ?? FontWeight.w600,
            color: textColor ?? AppColourUtils.kDarkerTextColor,
            overflow: textOverflow ?? TextOverflow.ellipsis,
            fontSize: fontSize ?? 14.0
        ));
  }
}
