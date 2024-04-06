import 'package:flutter/material.dart';
import 'package:nymble_assignment/utils/colour_utils.dart';
class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Screen Not Found",
          style: TextStyle(
              fontSize: 16,
              color: AppColourUtils.kGreyColor,
              fontFamily: "Poppins")),
    );
  }
}
