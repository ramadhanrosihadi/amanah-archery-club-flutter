import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:starter_d/data/provider/navigation_bar_provider.dart';
import 'package:starter_d/helper/constant/var.dart';
import 'package:starter_d/helper/constant/vcolor.dart';
import 'package:starter_d/ui/autentikasi/ui/splash_screen.dart';
import 'package:starter_d/ui/main/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        title: Var.appName,
        themeMode: ThemeMode.light,
        theme: ThemeData.light().copyWith(
          primaryColor: VColor.colorPrimary,
          textTheme: GoogleFonts.robotoTextTheme().apply(bodyColor: VColor.textColor, displayColor: VColor.textColor),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
