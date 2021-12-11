import 'package:flutter/material.dart';
import 'package:starter_d/helper/util/fun.dart';
import 'package:starter_d/helper/util/vtime.dart';

import 'package:starter_d/helper/widget/scaffold_default.dart';
import 'package:starter_d/ui/pelatihan/data/sesi.dart';
import 'package:starter_d/ui/pelatihan/ui/detail_sesi/widgets/item_info.dart';

class DetailSesiScreen extends StatefulWidget {
  DetailSesiScreen({
    Key? key,
    required this.sesi,
  }) : super(key: key);
  final Sesi sesi;

  @override
  _DetailSesiScreenState createState() => _DetailSesiScreenState();
}

class _DetailSesiScreenState extends State<DetailSesiScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldDefault(
      textTitle: 'Sesi Detail',
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              ItemInfo(label: 'Lokasi latihan', value: widget.sesi.catatan),
              const SizedBox(height: 15),
              ItemInfo(label: 'Tanggal', value: VTime.defaultFormat(Fun.replaceEmpty(widget.sesi.tanggal), to: 'dd MMMM yyy')),
              const SizedBox(height: 15),
              ItemInfo(label: 'Jam Mulai', value: widget.sesi.waktuMulai.toString()),
              const SizedBox(height: 15),
              ItemInfo(label: 'Jam Selesai', value: widget.sesi.waktuSelesai.toString()),
              const SizedBox(height: 15),
              const ItemInfo(label: 'Kehadiran', value: '-'),
              const SizedBox(height: 15),
              const ItemInfo(label: 'Skoring', value: '-'),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
