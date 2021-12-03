import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_d/data/provider/navigation_bar_provider.dart';
import 'package:starter_d/helper/constant/vcolor.dart';
import 'package:starter_d/helper/widget/coming_soon.dart';
import 'package:starter_d/helper/widget/responsive/responsive_layout.dart';
import 'package:starter_d/ui/main/data/menu_model.dart';
import 'package:starter_d/ui/main/main_screen_desktop.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NavigationBarProvider>(context);
    return ResponsiveLayout(
      mobile: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: provider.currentIndex,
          onTap: (index) {
            provider.currentIndex = index;
          },
          items: MenuModel.getListMenuModel().map((e) => e.getBottomNavigationBarItem(provider.currentIndex)).toList(),
          backgroundColor: Colors.white,
          selectedLabelStyle: TextStyle(color: VColor.colorPrimary),
          selectedItemColor: VColor.colorPrimary,
        ),
        body: MenuModel.getListMenuModel()[provider.currentIndex].screen,
      ),
      desktop: const MainScreenDesktop(),
    );
  }
}
