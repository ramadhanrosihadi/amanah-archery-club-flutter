import 'package:flutter/material.dart';
import 'package:starter_d/helper/constant/vcolor.dart';
import 'package:starter_d/helper/util/nav.dart';
import 'package:starter_d/ui/keanggotaan/ui/main/keanggotaan_main_screen.dart';
import 'package:starter_d/ui/main/data/menu_model.dart';
import 'package:starter_d/ui/pelatihan/ui/absensi/main/absensi_main_screen.dart';
import 'package:starter_d/ui/pelatihan/ui/main/pelatihan_main_screen.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<MenuModel> menus = [
    MenuModel(0, 'Anggota', KeanggotaanMainScreen(), Icons.usb_rounded),
    MenuModel(1, 'Pelatihan', PelatihanMainScreen(), Icons.exit_to_app),
    MenuModel(2, 'Absensi', AbsensiMainScreen(), Icons.note_alt_sharp),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset('assets/images/logo.png'),
              ),
              const SizedBox(height: 40),
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
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: VColor.colorPrimary),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(data.iconData, size: 30, color: Colors.white),
                              const SizedBox(height: 15),
                              Text(
                                data.label,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
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
