import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({Key? key, this.mobile, this.tablet, this.desktop}) : super(key: key);
  final Widget? mobile;
  final Widget? tablet;
  final Widget? desktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, dimens) {
      if (dimens.maxWidth >= 1200 && desktop != null) {
        return desktop!;
      } else if (dimens.maxWidth >= 700 && tablet != null) {
        return tablet!;
      } else if (mobile != null) {
        return mobile!;
      }
      return const SizedBox();
    });
  }
}
