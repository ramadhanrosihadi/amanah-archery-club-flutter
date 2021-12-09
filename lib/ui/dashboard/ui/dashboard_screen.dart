import 'package:flutter/material.dart';
import 'package:starter_d/helper/constant/vcolor.dart';
import 'package:starter_d/helper/util/nav.dart';
import 'package:starter_d/ui/keanggotaan/ui/main/keanggotaan_main_screen.dart';
import 'package:starter_d/ui/main/data/menu_model.dart';
import 'package:starter_d/ui/pelatihan/ui/main/pelatihan_main_screen.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<MenuModel> menus = [
    MenuModel(0, 'Anggota Klub', KeanggotaanMainScreen(), Icons.usb_rounded),
    MenuModel(1, 'Pelatihan', PelatihanMainScreen(), Icons.exit_to_app),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                'Amanah Archery',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: VColor.colorPrimary),
              ),
              const SizedBox(height: 20),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: menus.length,
                crossAxisSpacing: 15,
                children: menus
                    .map(
                      (data) => GestureDetector(
                        onTap: () {
                          Nav.push(context, data.screen);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          // margin: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), boxShadow: [
                            BoxShadow(
                              color: VColor.colorPrimary.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 1,
                            ),
                          ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(data.iconData, size: 30),
                              const SizedBox(height: 15),
                              Text(data.label),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
                padding: const EdgeInsets.all(0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
