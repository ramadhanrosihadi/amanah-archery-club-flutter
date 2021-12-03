import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_d/data/provider/navigation_bar_provider.dart';
import 'package:starter_d/helper/constant/vcolor.dart';
import 'package:starter_d/helper/widget/web_gesture_detector.dart';
import 'package:starter_d/ui/main/data/menu_model.dart';
import 'package:starter_d/ui/main/widget/top_navigation_bar.dart';
import 'package:starter_d/ui/main/widget/top_navigation_bar_item.dart';

class MainScreenDesktop extends StatelessWidget {
  const MainScreenDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<NavigationBarProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          TopNavigationBar(
            onSelect: (index) {
              repository.currentIndex = index;
            },
            currentPosition: repository.currentIndex,
          ),
          Expanded(
            child: MenuModel.getListMenuModel()[repository.currentIndex].screen,
          ),
        ],
      ),
    );
  }
}
