import 'package:flutter/material.dart';

import 'package:starter_d/helper/constant/vcolor.dart';
import 'package:starter_d/helper/util/fun.dart';
import 'package:starter_d/helper/util/nav.dart';

class AppBarDefault extends StatelessWidget {
  const AppBarDefault({
    Key? key,
    this.title = '',
    this.actions = const [],
    this.leadingOnPressed,
  }) : super(key: key);
  final String? title;
  final List<Widget> actions;
  final Function()? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1.0,
      title: Text(
        Fun.replaceEmpty(title),
        style: TextStyle(color: VColor.textColor, fontSize: 15, fontWeight: FontWeight.w800),
      ),
      // centerTitle: true,
      brightness: Brightness.light,
      titleSpacing: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          size: 23,
          color: VColor.textColor,
        ),
        onPressed: leadingOnPressed == null ? () => Nav.pop(context) : leadingOnPressed,
      ),
      iconTheme: IconThemeData(
        color: VColor.textColor,
        size: 20,
      ),
      actions: actions,
    );
  }
}
