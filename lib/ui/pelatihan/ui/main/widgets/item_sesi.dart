import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starter_d/helper/constant/vcolor.dart';
import 'package:starter_d/helper/util/fun.dart';
import 'package:starter_d/helper/util/vtime.dart';
import 'package:starter_d/ui/keanggotaan/data/anggota.dart';
import 'package:starter_d/ui/pelatihan/data/sesi.dart';

class ItemSesi extends StatelessWidget {
  final Sesi data;
  const ItemSesi({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        color: data.waktuSelesai == null ? Colors.green : VColor.colorPrimary,
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              VTime.defaultFormat(Fun.replaceEmpty(data.tanggal), to: 'dd MMMM yyyy'),
              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 3),
            Text(
              Fun.replaceEmpty(data.catatan),
              style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 3),
            Text(
              '${data.getWaktuMulai()} s/d ${data.getWaktuSelesai()}',
              style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Jumlah peserta',
                        style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '${data.kehadiran.length} orang',
                        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                // Expanded(
                //     child: Column(
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     const Text(
                //       'Tanggal Bergabung',
                //       style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w400),
                //     ),
                //     Text(
                //       Fun.re,
                //       style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
                //     ),
                //   ],
                // ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
