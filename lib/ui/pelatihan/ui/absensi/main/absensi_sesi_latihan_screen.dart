import 'package:flutter/material.dart';
import 'package:starter_d/data/preference/user_pref.dart';
import 'package:starter_d/helper/widget/scaffold_default.dart';
import 'package:starter_d/ui/keanggotaan/data/anggota.dart';

import 'package:starter_d/ui/pelatihan/data/sesi.dart';
import 'package:starter_d/ui/pelatihan/ui/absensi/main/widgets/sesi_aktif_card.dart';

class AbsensiSesiLatihanScreen extends StatefulWidget {
  AbsensiSesiLatihanScreen({
    Key? key,
    required this.sesi,
  }) : super(key: key);
  final Sesi sesi;

  @override
  _AbsensiSesiLatihanScreenState createState() => _AbsensiSesiLatihanScreenState();
}

class _AbsensiSesiLatihanScreenState extends State<AbsensiSesiLatihanScreen> {
  Anggota? user;

  @override
  void initState() {
    super.initState();
    UserPref.loadUser().then((value) => setState(() => user = value));
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldDefault(
      textTitle: 'Absen Latihanx',
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(height: 30),
              SesiAktifCard(disableTap: true),
            ],
          ),
        ),
      ),
    );
  }
}
