import 'package:flutter/material.dart';
import 'package:starter_d/helper/widget/button_default.dart';
import 'package:starter_d/helper/widget/field_custom.dart';
import 'package:starter_d/helper/widget/scaffold_default.dart';
import 'package:starter_d/ui/keanggotaan/data/anggota.dart';

class KeanggotaanUpsertScreen extends StatefulWidget {
  KeanggotaanUpsertScreen({Key? key, this.anggota}) : super(key: key);
  final Anggota? anggota;

  @override
  _KeanggotaanUpsertScreenState createState() => _KeanggotaanUpsertScreenState();
}

class _KeanggotaanUpsertScreenState extends State<KeanggotaanUpsertScreen> {
  TextEditingController namaController = TextEditingController();
  TextEditingController nomorHpController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController tanggalLahirController = TextEditingController();
  TextEditingController tanggalDaftarController = TextEditingController();
  TextEditingController jenisKelaminController = TextEditingController();
  TextEditingController nikController = TextEditingController();
  TextEditingController pekerjaanController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ScaffoldDefault(
      textTitle: widget.anggota != null ? widget.anggota!.nama : 'Anggota Baru',
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              FieldCustom(controller: namaController, label: 'Nama'),
              const SizedBox(height: 15),
              FieldCustom(
                controller: jenisKelaminController,
                label: 'Jenis Kelamin',
                // onTap: () {},
              ),
              const SizedBox(height: 15),
              FieldCustom(controller: nomorHpController, label: 'Nomor HP'),
              const SizedBox(height: 15),
              FieldCustom(controller: alamatController, label: 'Alamat'),
              const SizedBox(height: 15),
              FieldCustom(
                controller: tanggalLahirController,
                label: 'Tanggal Lahir',
                // onTap: () {},
              ),
              const SizedBox(height: 15),
              FieldCustom(
                controller: tanggalDaftarController,
                label: 'Tanggal Daftar',
                // onTap: () {},
              ),
              const SizedBox(height: 15),
              FieldCustom(controller: nikController, label: 'NIK'),
              const SizedBox(height: 15),
              FieldCustom(controller: pekerjaanController, label: 'Pekerjaan'),
              const SizedBox(height: 15),
              ButtonDefault(text: 'SIMPAN'),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
