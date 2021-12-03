import 'package:flutter/material.dart';
import 'package:starter_d/helper/constant/vcolor.dart';

class TopNavigationBarItem extends StatelessWidget {
  const TopNavigationBarItem({Key? key, @required this.label, this.isActive = true}) : super(key: key);
  final String? label;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      decoration: BoxDecoration(color: isActive ? Colors.white : VColor.colorPrimary, borderRadius: BorderRadius.circular(30)),
      child: Center(
        child: Text(
          label!,
          style: TextStyle(fontWeight: isActive ? FontWeight.bold : FontWeight.w700, color: isActive ? VColor.colorPrimary : Colors.white, fontSize: isActive ? 16 : 14),
        ),
      ),
    );
  }
}
