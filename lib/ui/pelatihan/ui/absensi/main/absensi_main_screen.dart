import 'package:flutter/material.dart';
import 'package:starter_d/helper/constant/vcolor.dart';
import 'package:starter_d/helper/widget/scaffold_default.dart';
import 'package:starter_d/ui/pelatihan/ui/absensi/main/widgets/sesi_aktif_card.dart';
import 'package:starter_d/ui/pelatihan/ui/main/widgets/item_sesi.dart';

class AbsensiMainScreen extends StatefulWidget {
  AbsensiMainScreen({Key? key}) : super(key: key);

  @override
  _AbsensiMainScreenState createState() => _AbsensiMainScreenState();
}

class _AbsensiMainScreenState extends State<AbsensiMainScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldDefault(
      textTitle: 'Absensi Kehadiran',
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Sesi Latihan Aktif',
                style: TextStyle(color: VColor.textColor, fontSize: 15),
              ),
              const SizedBox(height: 10),
              const SesiAktifCard(),
              const SizedBox(height: 20),
              Text(
                'Riwayat kehadiran',
                style: TextStyle(color: VColor.textColor, fontSize: 15),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
