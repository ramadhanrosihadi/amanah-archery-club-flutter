import 'package:flutter/material.dart';
import 'package:starter_d/helper/util/nav.dart';
import 'package:starter_d/helper/widget/button_default.dart';
import 'package:starter_d/ui/autentikasi/ui/signin_screen.dart';

class MainProfileScreen extends StatefulWidget {
  MainProfileScreen({Key? key}) : super(key: key);

  @override
  _MainProfileScreenState createState() => _MainProfileScreenState();
}

class _MainProfileScreenState extends State<MainProfileScreen> {
  @override
  Widget build(BuildContext context) {
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
