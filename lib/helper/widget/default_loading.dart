import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class DefaultLoading extends StatelessWidget {
  const DefaultLoading({
    Key? key,
    this.height,
  }) : super(key: key);
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Center(child: LoadingIndicator(indicatorType: Indicator.pacman, colors: [Colors.black, Colors.red, Colors.blue], backgroundColor: Colors.white, pathBackgroundColor: Colors.white)),
    );
  }
}
