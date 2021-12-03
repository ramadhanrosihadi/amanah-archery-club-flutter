import 'package:flutter/material.dart';

class WebGestureDetector extends StatelessWidget {
  const WebGestureDetector({Key? key, this.onTap, @required this.child}) : super(key: key);
  final Function()? onTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: child,
      ),
    );
  }
}
