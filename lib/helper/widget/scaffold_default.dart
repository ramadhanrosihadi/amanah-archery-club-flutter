import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:starter_d/helper/constant/vcolor.dart';
import 'package:starter_d/helper/widget/appbar_default.dart';

class ScaffoldDefault extends StatelessWidget {
  const ScaffoldDefault({Key? key, this.textTitle, this.backgroundColor = Colors.white, required this.body, this.customAppBar}) : super(key: key);
  final String? textTitle;
  final Color backgroundColor;
  final Widget body;
  final PreferredSizeWidget? customAppBar;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: VColor.colorPrimary,
      statusBarColor: Colors.white,
    ));
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: PreferredSize(
            child: customAppBar != null ? customAppBar! : AppBarDefault(title: textTitle),
            preferredSize: const Size.fromHeight(60),
          ),
          body: body,
        ),
      ),
    );
  }
}
