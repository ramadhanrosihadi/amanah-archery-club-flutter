import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starter_d/helper/constant/vcolor.dart';
import 'package:starter_d/helper/widget/web_gesture_detector.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({Key? key, this.message = ''}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Container(width: 250, height: 3, color: VColor.colorPrimary),
          // const SizedBox(height: 10),
          WebGestureDetector(
            onTap: () {
              if (Get.isDarkMode) {
                Get.changeThemeMode(ThemeMode.light);
              } else {
                Get.changeThemeMode(ThemeMode.dark);
              }
            },
            child: Text(
              'Coming Soon',
              style: Theme.of(context).textTheme.headline5!.copyWith(color: VColor.colorPrimary),
            ),
          ),
          Text(
            message,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(color: VColor.colorPrimary),
          ),
          // const SizedBox(height: 10),
          // Container(width: 250, height: 3, color: VColor.colorPrimary),
        ],
      ),
    );
  }
}
