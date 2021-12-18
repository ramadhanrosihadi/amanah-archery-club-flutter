import 'package:flutter/material.dart';
import 'package:starter_d/data/preference/user_pref.dart';
import 'package:starter_d/helper/util/nav.dart';
import 'package:starter_d/helper/widget/button_default.dart';
import 'package:starter_d/ui/autentikasi/ui/signin_screen.dart';
import 'package:starter_d/ui/keanggotaan/data/anggota.dart';

class MainProfileScreen extends StatefulWidget {
  MainProfileScreen({Key? key}) : super(key: key);

  @override
  _MainProfileScreenState createState() => _MainProfileScreenState();
}

class _MainProfileScreenState extends State<MainProfileScreen> {
  Anggota? user;
  @override
  void initState() {
    super.initState();
    UserPref.loadUser().then((value) {
      setState(() {
        user = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      return SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Hi ${user!.nama}',
                style: TextStyle(fontSize: 17),
              ),
              const SizedBox(height: 20),
              ButtonDefault(
                text: 'KELUAR',
                onPressed: () async {
                  await UserPref.clear(context);
                  setState(() {
                    user = null;
                  });
                },
              ),
            ],
          ),
        ),
      );
    }
    return SafeArea(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Silahkan masuk terlebih dahulu',
              style: TextStyle(fontSize: 17),
            ),
            const SizedBox(height: 20),
            ButtonDefault(
              text: 'Masuk',
              onPressed: () async {
                await Nav.push(context, SigninScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
