import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:starter_d/helper/constant/var.dart';
import 'package:starter_d/helper/util/nav.dart';
import 'package:starter_d/helper/util/vdialog.dart';
import 'package:starter_d/helper/widget/button_default.dart';
import 'package:starter_d/helper/widget/field_custom.dart';
import 'package:starter_d/helper/widget/scaffold_default.dart';
import 'package:starter_d/ui/keanggotaan/data/anggota.dart';
import 'package:starter_d/ui/main/main_screen.dart';

class SigninScreen extends StatefulWidget {
  SigninScreen({Key? key}) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    if (Var.isDebugMode) {
      setState(() {
        usernameController.text = '082245947379';
        passwordController.text = 'amanah';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  Image.asset('assets/images/logo.png'),
                  const SizedBox(height: 50),
                  FieldCustom(
                    controller: usernameController,
                    label: 'Nomor HP',
                    textInputType: TextInputType.phone,
                  ),
                  const SizedBox(height: 10),
                  FieldCustom(
                    controller: passwordController,
                    label: 'Kata Sandi',
                    isPassword: true,
                  ),
                  const SizedBox(height: 30),
                  Builder(builder: (context) {
                    if (isLoading) {
                      return CircularProgressIndicator();
                    }
                    return ButtonDefault(
                      text: 'MASUK',
                      onPressed: () async {
                        setState(() => isLoading = true);
                        bool result = false;
                        try {
                          result = await Anggota.signin(context, usernameController.text, passwordController.text);
                        } catch (e) {
                          VDialog.createDialog(context, message: e.toString());
                        }
                        setState(() => isLoading = false);
                        if (result) {
                          Nav.pushAndRemoveUntil(context, MainScreen());
                        }
                      },
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
