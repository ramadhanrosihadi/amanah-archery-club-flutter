import 'package:flutter/material.dart';
import 'package:starter_d/helper/constant/var.dart';
import 'package:starter_d/helper/constant/vcolor.dart';
import 'package:starter_d/helper/util/fun.dart';
import 'package:starter_d/helper/util/nav.dart';
import 'package:starter_d/helper/util/vdialog.dart';
import 'package:starter_d/helper/util/vtime.dart';
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
  Anggota anggota = Anggota();
  TextEditingController namaController = TextEditingController();
  TextEditingController jenisKelaminController = TextEditingController();
  TextEditingController nomorHpController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController tanggalLahirController = TextEditingController();
  TextEditingController tanggalDaftarController = TextEditingController();
  TextEditingController nikController = TextEditingController();
  TextEditingController pekerjaanController = TextEditingController();
  DateTime? tanggalLahir;
  DateTime? tanggalDaftar;

  @override
  void initState() {
    super.initState();
    if (widget.anggota == null && Var.isDebugMode) {
      setState(() {
        namaController.text = 'Ramadhan Rosihadi Perdana';
        jenisKelaminController.text = 'Ikhwan';
        nomorHpController.text = '082245947379';
        alamatController.text = 'Jl. Wonorejo Timur no.9, Rungkut, Surabaya';
        tanggalLahirController.text = '2021-03-12';
        tanggalLahir = DateTime(1994, 3, 12);
        tanggalDaftarController.text = '2021-12-10';
        tanggalDaftar = DateTime(2021, 12, 10);
        nikController.text = '0123456789123456';
        pekerjaanController.text = 'Programmer';
      });
    } else if (widget.anggota != null) {
      setState(() {
        anggota = widget.anggota!;
        namaController.text = anggota.nama;
        jenisKelaminController.text = anggota.jenisKelamin;
        nomorHpController.text = anggota.nomorHp;
        alamatController.text = anggota.alamat;
        tanggalLahirController.text = VTime.defaultFormat(anggota.tanggalLahirString(), to: 'dd/MM/yyy');
        tanggalLahir = anggota.tanggalLahir;
        tanggalDaftarController.text = VTime.defaultFormat(anggota.tanggalBergabungString(), to: 'dd/MM/yyy');
        tanggalDaftar = anggota.tanggalBergabung;
        nikController.text = anggota.nik;
        pekerjaanController.text = anggota.pekerjaan;
      });
    }
  }

  bool isValid() {
    if (namaController.text.isEmpty) {
      VDialog.createDialog(context, message: 'Nama anggota wajib diisi', title: 'Gagal');
      return false;
    } else if (jenisKelaminController.text.isEmpty) {
      VDialog.createDialog(context, message: 'Jenis kelamin wajib diisi', title: 'Gagal');
      return false;
    } else if (nomorHpController.text.isEmpty) {
      VDialog.createDialog(context, message: 'Nomor hp wajib diisi', title: 'Gagal');
      return false;
    } else if (alamatController.text.isEmpty) {
      VDialog.createDialog(context, message: 'Alamat wajib diisi', title: 'Gagal');
      return false;
    } else if (tanggalLahir == null) {
      VDialog.createDialog(context, message: 'Tanggal lahir wajib diisi', title: 'Gagal');
      return false;
    } else if (tanggalDaftar == null) {
      VDialog.createDialog(context, message: 'Tanggal daftar wajib diisi', title: 'Gagal');
      return false;
    } else if (nikController.text.isEmpty) {
      VDialog.createDialog(context, message: 'NIK wajib diisi', title: 'Gagal');
      return false;
    } else if (pekerjaanController.text.isEmpty) {
      VDialog.createDialog(context, message: 'Pekerjaan wajib diisi', title: 'Gagal');
      return false;
    }
    anggota.nama = namaController.text;
    anggota.jenisKelamin = jenisKelaminController.text;
    anggota.nomorHp = nomorHpController.text;
    anggota.alamat = alamatController.text;
    anggota.tanggalLahir = tanggalLahir;
    anggota.tanggalBergabung = tanggalDaftar;
    anggota.nik = nikController.text;
    anggota.pekerjaan = pekerjaanController.text;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldDefault(
      textTitle: widget.anggota != null ? 'Edit Data Anggota' : 'Tambah Anggota Baru',
      actions: [
        Visibility(
          visible: widget.anggota != null,
          child: PopupMenuButton<String>(
            onSelected: (value) async {
              bool result = await VDialog.createDialog(context, message: 'Apakah anda yakin akan menghapus data anggota ${widget.anggota!.nama}?');
              if (result) {
                await widget.anggota!.delete();
                Nav.pop(context, true);
                // Nav.pop(context, true);
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Delete'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(
                    choice,
                    style: TextStyle(color: VColor.textColor),
                  ),
                );
              }).toList();
            },
          ),
        ),
      ],
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
                onTapDown: (TapDownDetails tapDownDetails) async {
                  String? result = await VDialog.showListPopUp(context, tapDownDetails, ['Ikhwan', 'Akhwat'], null);
                  if (result != null) {
                    setState(() {
                      jenisKelaminController.text = result;
                    });
                  }
                  Fun.showLog('result: $result');
                },
              ),
              const SizedBox(height: 15),
              FieldCustom(
                controller: nomorHpController,
                label: 'Nomor HP',
                textInputType: TextInputType.phone,
              ),
              const SizedBox(height: 15),
              FieldCustom(controller: alamatController, label: 'Alamat'),
              const SizedBox(height: 15),
              FieldCustom(
                controller: tanggalLahirController,
                label: 'Tanggal Lahir',
                onTapDown: (TapDownDetails tapDownDetails) async {
                  Fun.closeKeyboard(context);
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime(DateTime.now().year - 100),
                    lastDate: DateTime.now(),
                    helpText: 'Pilih tanggal lahir',
                    initialDate: DateTime(DateTime.now().year - 25),
                  );
                  if (pickedDate != null) {
                    String result = pickedDate.toString().substring(0, 10);
                    setState(() {
                      tanggalLahir = pickedDate;
                      tanggalLahirController.text = result;
                    });
                  }
                },
              ),
              const SizedBox(height: 15),
              FieldCustom(
                controller: tanggalDaftarController,
                label: 'Tanggal Daftar',
                onTapDown: (TapDownDetails tapDownDetails) async {
                  Fun.closeKeyboard(context);
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime(DateTime.now().month - 3),
                    lastDate: DateTime.now(),
                    helpText: 'Pilih tanggal pendaftaran',
                    initialDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    String result = pickedDate.toString().substring(0, 10);
                    setState(() {
                      tanggalDaftar = pickedDate;
                      tanggalDaftarController.text = result;
                    });
                  }
                },
              ),
              const SizedBox(height: 15),
              FieldCustom(
                controller: nikController,
                label: 'NIK',
                textInputType: TextInputType.number,
                maxLength: 16,
              ),
              const SizedBox(height: 15),
              FieldCustom(controller: pekerjaanController, label: 'Pekerjaan'),
              const SizedBox(height: 30),
              ButtonDefault(
                text: 'SIMPAN',
                onPressed: () async {
                  if (isValid()) {
                    if (widget.anggota != null) {
                      await Anggota.update(context, anggota);
                      await VDialog.createDialog(context, message: 'Perubahan data berhasil disimpan', withBackButton: false);
                    } else {
                      await Anggota.insert(context, anggota);
                      await VDialog.createDialog(context, message: 'Anggota baru berhasil ditambahkan', withBackButton: false);
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
