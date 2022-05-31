import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starter_d/helper/constant/vcolor.dart';
import 'package:starter_d/helper/util/fun.dart';
import 'package:starter_d/ui/keanggotaan/data/anggota.dart';

class ItemAnggota extends StatelessWidget {
  final Anggota anggota;
  const ItemAnggota({Key? key, required this.anggota}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade600),
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '${Fun.replaceEmpty(anggota.nama)}',
            style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 3),
          Text(
            '${Fun.replaceEmpty(anggota.jenisKelamin)} - ${anggota.umur()}',
            style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
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
                      style: TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      '${anggota.totalLatihan}x',
                      style: const TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w700),
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
                    style: TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    anggota.tanggalBergabungString(),
                    style: const TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                ],
              ))
            ],
          )
        ],
      ),
    );
  }
}
