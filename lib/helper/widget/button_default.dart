import 'package:flutter/material.dart';
import 'package:starter_d/helper/constant/vcolor.dart';
import 'package:starter_d/helper/widget/web_gesture_detector.dart';

class ButtonDefault extends StatelessWidget {
  String text;
  Function()? onPressed;
  double? height;
  double? width;
  double? fontSize;
  Color? color;
  String? leftAssetPath;
  FontWeight? fontWeight;
  Color? textColor;
  double? paddingHorizontal;
  double? paddingVertical;
  Widget? leftAsset;
  Color? borderColor;
  double? borderWidth;
  double? blurRadius;
  double? spreadRadius;
  double? borderRadius;
  ButtonDefault({
    Key? key,
    required this.text,
    this.onPressed,
    this.height,
    this.width = double.infinity,
    this.fontSize = 15,
    this.color,
    this.leftAssetPath,
    this.fontWeight,
    this.textColor = Colors.white,
    this.paddingHorizontal = 15,
    this.paddingVertical = 15,
    this.leftAsset,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0.0,
    this.blurRadius = 2,
    this.spreadRadius = 1.2,
    this.borderRadius = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? bgColor;
    if (color == null) {
      bgColor = VColor.colorPrimary;
    } else {
      bgColor = color;
    }
    return WebGestureDetector(
      // style: TextButton.styleFrom(
      //   padding: EdgeInsets.zero,
      // ),
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius!),
          border: Border.all(color: borderColor!, width: borderWidth!),
          color: bgColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: spreadRadius!,
              blurRadius: blurRadius!,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: paddingHorizontal!, vertical: paddingVertical!),
        child: Row(
          children: [
            leftAssetPath != null
                ? Image.asset('assets/images/$leftAssetPath', height: 30)
                : leftAsset != null
                    ? leftAsset!
                    : const SizedBox(),
            Expanded(
              child: Center(
                child: Text(
                  text!,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: fontWeight,
                    fontSize: fontSize,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
