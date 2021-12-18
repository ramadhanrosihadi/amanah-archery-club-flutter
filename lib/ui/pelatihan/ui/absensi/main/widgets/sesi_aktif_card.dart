import 'package:flutter/material.dart';
import 'package:starter_d/helper/util/nav.dart';
import 'package:starter_d/ui/pelatihan/data/sesi.dart';
import 'package:starter_d/ui/pelatihan/ui/absensi/main/absensi_sesi_latihan_screen.dart';
import 'package:starter_d/ui/pelatihan/ui/main/widgets/item_sesi.dart';

class SesiAktifCard extends StatefulWidget {
  const SesiAktifCard({Key? key, this.disableTap = false}) : super(key: key);
  final bool disableTap;

  @override
  State<SesiAktifCard> createState() => _SesiAktifCardState();
}

class _SesiAktifCardState extends State<SesiAktifCard> {
  Sesi? sesiAktif;
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    List<Sesi> datas = await Sesi.gets();
    for (Sesi item in datas) {
      if (item.waktuSelesai == null) {
        setState(() {
          sesiAktif = item;
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (sesiAktif == null) {
        return const SizedBox();
      }
      return GestureDetector(
        child: ItemSesi(data: sesiAktif!),
        onTap: widget.disableTap
            ? null
            : () {
                if (sesiAktif != null) {
                  Nav.push(context, AbsensiSesiLatihanScreen(sesi: sesiAktif!));
                }
              },
      );
    });
  }
}
