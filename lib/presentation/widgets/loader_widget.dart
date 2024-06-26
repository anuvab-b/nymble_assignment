import 'package:flutter/cupertino.dart';
import 'package:nymble_assignment/utils/theme_styles.dart';

class CommonLoader extends StatelessWidget {
  const CommonLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 72.0,
        width: 72.0,
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
            color: kBodyTextColorDark,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: const CupertinoActivityIndicator(radius: 20),
      ),
    );
  }
}
