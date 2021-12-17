import 'package:flutter/material.dart';
import 'package:starter_d/helper/widget/scaffold_default.dart';

class SigninScreen extends StatefulWidget {
  SigninScreen({Key? key}) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldDefault(
      textTitle: 'Masuk',
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
