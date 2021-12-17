import 'package:flutter/material.dart';
import 'package:starter_d/data/preference/user_pref.dart';
import 'package:starter_d/helper/util/nav.dart';
import 'package:starter_d/ui/autentikasi/ui/signin_screen.dart';
import 'package:starter_d/ui/main/main_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _visible = false;
  int durationAnimation = 1000;
  @override
  void initState() {
    super.initState();
    UserPref.isAuthenticated().then((isAuthenticated) {
      _setVisible(true);
      Future.delayed(Duration(milliseconds: durationAnimation)).then((value) {
        if (isAuthenticated) {
          Nav.push(context, MainScreen());
        } else {
          Nav.push(context, SigninScreen());
        }
      });
    });
  }

  void _setVisible(bool value) {
    setState(() {
      _visible = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: Center(
            child: AnimatedOpacity(
              opacity: _visible ? 1.0 : 0,
              duration: Duration(milliseconds: durationAnimation - 200),
              child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/images/logo.png'),
                  ))),
            ),
          ),
        ),
      ),
    );
  }
}
