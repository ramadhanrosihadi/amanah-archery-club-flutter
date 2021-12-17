import 'package:flutter/material.dart';
import 'package:starter_d/helper/util/nav.dart';
import 'package:starter_d/ui/keanggotaan/data/anggota.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPref {
  static Future<Anggota?> saveUser(Anggota user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', user.toJson());
    prefs.setString('username', user.nomorHp!);
    return Anggota.fromJson(prefs.getString('anggota'));
  }

  static Future<Anggota?> loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Anggota? user = Anggota.fromJson(prefs.getString('anggota'));
    return user;
  }

  static Future<bool> isAuthenticated() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Anggota? user = Anggota.fromJson(prefs.getString('anggota'));
    if (user != null && user.id != null) {
      return true;
    }
    return false;
  }

  static clear([BuildContext? context]) async {
    if (context != null) {
      // await VFirebase.signOutGoogle(context);
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    prefs.remove('gunakan_pin');
  }

  static signout([BuildContext? context]) async {
    clear(context);
    Nav.navAndRemoveUntil(
      'RoutePath.signin',
      'Sesi telah berakhir. Silahkan login kembali.',
    );
  }

  static Future<String?> loadLastUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('nomorHp');
  }
}
