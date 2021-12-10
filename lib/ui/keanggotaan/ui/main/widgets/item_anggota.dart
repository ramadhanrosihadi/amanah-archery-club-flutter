import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starter_d/helper/constant/vcolor.dart';
import 'package:starter_d/ui/keanggotaan/data/anggota.dart';

class ItemAnggota extends StatelessWidget {
  final Anggota anggota;
  const ItemAnggota({Key? key, required this.anggota}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        color: VColor.colorPrimary,
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              anggota.nama,
              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 3),
            Text(
              anggota.alamat,
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
                        'Total latihan',
                        style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '${anggota.totalLatihan}x',
                        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Tanggal Bergabung',
                      style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      anggota.tanggalBergabungString(),
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
                    ),
                  ],
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
