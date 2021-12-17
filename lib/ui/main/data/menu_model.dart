import 'package:flutter/material.dart';
import 'package:starter_d/helper/constant/vcolor.dart';
import 'package:starter_d/helper/widget/coming_soon.dart';
import 'package:starter_d/ui/dashboard/ui/dashboard_screen.dart';
import 'package:starter_d/ui/example/ui/task_list.dart';
import 'package:starter_d/ui/profile/ui/main_profile/main_profile_screen.dart';

class MenuModel {
  final String label;
  final int position;
  final IconData iconData;
  final Widget screen;

  MenuModel(
    this.position,
    this.label,
    this.screen,
    this.iconData,
  );

  static List<String> labels = ['Beranda', 'Aktivitas', 'Akun Saya'];

  static List<MenuModel> getListMenuModel() {
    return [
      MenuModel(0, labels[0], DashboardScreen(), Icons.home),
      MenuModel(1, labels[1], ComingSoon(message: labels[1]), Icons.dashboard),
      MenuModel(4, labels[2], MainProfileScreen(), Icons.person),
    ];
  }

  BottomNavigationBarItem getBottomNavigationBarItem(int currentPosition) {
    final isSelected = currentPosition == position;
    return BottomNavigationBarItem(
      icon: Icon(
        iconData,
        color: isSelected ? VColor.colorPrimary : VColor.colorPrimary.withOpacity(0.6),
      ),
      label: label,
    );
  }
}
