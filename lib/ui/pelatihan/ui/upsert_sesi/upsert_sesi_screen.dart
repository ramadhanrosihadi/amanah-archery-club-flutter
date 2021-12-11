import 'package:flutter/material.dart';

import 'package:starter_d/helper/util/fun.dart';
import 'package:starter_d/helper/util/nav.dart';
import 'package:starter_d/helper/util/vdialog.dart';
import 'package:starter_d/helper/util/vtime.dart';
import 'package:starter_d/helper/widget/button_default.dart';
import 'package:starter_d/helper/widget/field_custom.dart';
import 'package:starter_d/helper/widget/scaffold_default.dart';
import 'package:starter_d/ui/pelatihan/data/sesi.dart';

class UpsertSesiScreen extends StatefulWidget {
  UpsertSesiScreen({
    Key? key,
    this.sesi,
  }) : super(key: key);
  final Sesi? sesi;

  @override
  _UpsertSesiScreenState createState() => _UpsertSesiScreenState();
}

class _UpsertSesiScreenState extends State<UpsertSesiScreen> {
  Sesi sesi = Sesi();
  TextEditingController tanggalController = TextEditingController();
  TextEditingController waktuMulaiController = TextEditingController();
  TextEditingController waktuSelesaiController = TextEditingController();
  TextEditingController catatanController = TextEditingController();
  DateTime? tanggal;
  DateTime? waktuMulaiLatihan;
  DateTime? waktuSelesaiLatihan;

  bool isValid() {
    if (tanggal == null) {
      VDialog.createDialog(context, message: 'Tanggal wajib diisi');
      return false;
    } else if (waktuMulaiLatihan == null) {
      VDialog.createDialog(context, message: 'Waktu mulai wajib diisi');
      return false;
    } else if (catatanController.text.isEmpty) {
      VDialog.createDialog(context, message: 'Info lokasi wajib diisi');
      return false;
    }
    sesi.catatan = catatanController.text;
    sesi.tanggal = tanggal!.toIso8601String();
    sesi.waktuMulai = VTime.defaultFormat(waktuMulaiLatihan!.toIso8601String(), to: 'HH:mm:ss');
    if (waktuSelesaiLatihan != null) {
      sesi.waktuSelesai = VTime.defaultFormat(waktuSelesaiLatihan!.toIso8601String(), to: 'HH:mm:ss');
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    if (widget.sesi == null) {
      catatanController.text = 'Masjid As-Salam Purimas';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldDefault(
      textTitle: 'Buat Sesi Latihan',
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              FieldCustom(
                controller: catatanController,
                label: 'Lokasi latihan',
                textInputType: TextInputType.multiline,
              ),
              const SizedBox(height: 15),
              FieldCustom(
                controller: tanggalController,
                label: 'Tanggal Latihan',
                onTapDown: (TapDownDetails tapDownDetails) async {
                  Fun.closeKeyboard(context);
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime(DateTime.now().month - 3),
                    lastDate: DateTime.now(),
                    helpText: 'Pilih tanggal latihan',
                    initialDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    String result = pickedDate.toString().substring(0, 10);
                    setState(() {
                      DateTime defaultDate = DateTime.now();
                      tanggal = DateTime(defaultDate.year, defaultDate.month, defaultDate.day);
                      tanggalController.text = result;
                    });
                  }
                },
              ),
              const SizedBox(height: 15),
              FieldCustom(
                controller: waktuMulaiController,
                label: 'Jam Mulai Latihan',
                onTapDown: (TapDownDetails tapDownDetails) async {
                  Fun.closeKeyboard(context);
                  final TimeOfDay? result = await showTimePicker(
                    initialTime: TimeOfDay.now(),
                    context: context,
                  );
                  if (result != null) {
                    setState(() {
                      DateTime defaultDate = DateTime.now();
                      if (waktuMulaiLatihan != null) {
                        defaultDate = waktuMulaiLatihan!;
                      }
                      waktuMulaiLatihan = DateTime(defaultDate.year, defaultDate.month, defaultDate.day, result.hour, result.minute);
                      waktuMulaiController.text = result.format(context);
                    });
                  }
                },
              ),
              const SizedBox(height: 15),
              FieldCustom(
                controller: waktuSelesaiController,
                label: 'Jam Selesai Latihan',
                onTapDown: (TapDownDetails tapDownDetails) async {
                  Fun.closeKeyboard(context);
                  final TimeOfDay? result = await showTimePicker(
                    initialTime: TimeOfDay.now(),
                    context: context,
                  );
                  if (result != null) {
                    setState(() {
                      DateTime defaultDate = DateTime.now();
                      if (waktuSelesaiLatihan != null) {
                        defaultDate = waktuSelesaiLatihan!;
                      }
                      waktuSelesaiLatihan = DateTime(defaultDate.year, defaultDate.month, defaultDate.day, result.hour, result.minute);
                      waktuSelesaiController.text = result.format(context);
                    });
                  }
                },
              ),
              const SizedBox(height: 25),
              ButtonDefault(
                text: 'BUAT BARU',
                onPressed: () async {
                  if (isValid()) {
                    if (widget.sesi != null) {
                      await Sesi.update(context, sesi);
                      await VDialog.createDialog(context, message: 'Perubahan data berhasil disimpan', withBackButton: false);
                    } else {
                      bool result = await Sesi.insert(context, sesi);
                      if (result) {
                        await VDialog.createDialog(context, message: 'Sesi baru berhasil dibuat', withBackButton: false);
                      } else {
                        await VDialog.createDialog(context, message: 'Masih ada sesi aktif yang belum ditutup', title: 'Gagal', withBackButton: false);
                      }
                    }
                    Nav.pop(context);
                  }
                },
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
