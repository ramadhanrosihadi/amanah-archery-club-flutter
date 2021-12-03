import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:starter_d/helper/constant/vcolor.dart';
import 'package:starter_d/helper/widget/web_gesture_detector.dart';
import 'package:starter_d/ui/main/data/menu_model.dart';
import 'package:starter_d/ui/main/widget/top_navigation_bar_item.dart';

class TopNavigationBar extends StatelessWidget {
  const TopNavigationBar({Key? key, @required this.onSelect, this.currentPosition = 0}) : super(key: key);
  final Function(int value)? onSelect;
  final int currentPosition;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: VColor.colorPrimary),
      padding: const EdgeInsets.symmetric(horizontal: 250, vertical: 20),
      child: Row(
        children: [
          Image.asset('assets/images/logo-white.png', height: 50),
          const Expanded(child: const SizedBox()),
          Row(
            children: MenuModel.getListMenuModel()
                .map(
                  (e) => Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: WebGestureDetector(
                      onTap: () {
                        onSelect!(e.position);
                      },
                      child: TopNavigationBarItem(label: e.label, isActive: currentPosition == e.position),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
