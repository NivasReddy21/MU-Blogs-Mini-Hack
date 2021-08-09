import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CenterView extends StatelessWidget {
  final Widget child;

  const CenterView({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      var padding =
          sizingInformation.deviceScreenType == DeviceScreenType.mobile
              ? EdgeInsets.all(20)
              : EdgeInsets.all(30);

      return Container(
        padding: padding,
        alignment: Alignment.center,
        child: child,
      );
    });
  }
}
