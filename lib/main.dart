import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:starter_d/data/provider/navigation_bar_provider.dart';
import 'package:starter_d/helper/constant/vcolor.dart';
import 'package:starter_d/ui/main/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationBarProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Awesome App',
        themeMode: ThemeMode.system,
        darkTheme: ThemeData.dark().copyWith(
          primaryColor: VColor.colorPrimary,
          textTheme: GoogleFonts.robotoTextTheme()
              .copyWith(
                headline1: GoogleFonts.raleway().copyWith(fontSize: 55, fontWeight: FontWeight.bold, color: Colors.white),
                headline2: GoogleFonts.raleway().copyWith(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white),
                headline3: GoogleFonts.raleway().copyWith(fontSize: 45, fontWeight: FontWeight.bold, color: Colors.white),
                headline4: GoogleFonts.raleway().copyWith(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
                headline5: GoogleFonts.raleway().copyWith(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
                headline6: GoogleFonts.raleway().copyWith(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
              )
              .apply(bodyColor: Colors.white, displayColor: Colors.white),
        ),
        theme: ThemeData.light().copyWith(
          primaryColor: VColor.colorPrimary,
          textTheme: GoogleFonts.robotoTextTheme()
              .copyWith(
                headline1: GoogleFonts.raleway().copyWith(fontSize: 55, fontWeight: FontWeight.bold, color: VColor.textColor),
                headline2: GoogleFonts.raleway().copyWith(fontSize: 50, fontWeight: FontWeight.bold, color: VColor.textColor),
                headline3: GoogleFonts.raleway().copyWith(fontSize: 45, fontWeight: FontWeight.bold, color: VColor.textColor),
                headline4: GoogleFonts.raleway().copyWith(fontSize: 40, fontWeight: FontWeight.bold, color: VColor.textColor),
                headline5: GoogleFonts.raleway().copyWith(fontSize: 35, fontWeight: FontWeight.bold, color: VColor.textColor),
                headline6: GoogleFonts.raleway().copyWith(fontSize: 30, fontWeight: FontWeight.bold, color: VColor.textColor),
              )
              .apply(bodyColor: VColor.textColor, displayColor: VColor.textColor),
        ),
        home: MainScreen(),
      ),
    );
  }
}
