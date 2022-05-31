import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:starter_d/data/preference/user_pref.dart';
import 'package:starter_d/helper/constant/var.dart';
import 'package:starter_d/helper/constant/vcolor.dart';
import 'package:starter_d/helper/util/fun.dart';
import 'package:starter_d/helper/util/nav.dart';
import 'package:starter_d/helper/util/vdialog.dart';
import 'package:starter_d/helper/util/vtime.dart';
import 'package:starter_d/helper/widget/button_default.dart';
import 'package:starter_d/helper/widget/field_custom.dart';
import 'package:starter_d/helper/widget/loading_view.dart';
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
  TextEditingController aksesController = TextEditingController();
  Timestamp? tanggalLahir;
  Timestamp? tanggalDaftar;
  bool isLoading = false;
  Anggota? user;

  @override
  void initState() {
    super.initState();
    if (widget.anggota != null) {
      setState(() {
        anggota = widget.anggota!;
        namaController.text = Fun.replaceEmpty(anggota.nama);
        jenisKelaminController.text = Fun.replaceEmpty(anggota.jenisKelamin);
        nomorHpController.text = Fun.replaceEmpty(anggota.nomorHp);
        alamatController.text = Fun.replaceEmpty(anggota.alamat);
        tanggalLahirController.text = anggota.tanggalLahirString();
        tanggalLahir = anggota.tanggalLahir;
        tanggalDaftarController.text = anggota.tanggalBergabungString();
        tanggalDaftar = anggota.tanggalBergabung;
        pekerjaanController.text = Fun.replaceEmpty(anggota.pekerjaan);
        aksesController.text = Fun.replaceEmpty(anggota.roles);
      });
    }
    UserPref.loadUser().then((value) {
      setState(() {
        user = value;
      });
    });
  }

  bool isValid() {
    if (namaController.text.isEmpty) {
      VDialog.createDialog(context, message: 'Nama anggota wajib diisi', title: 'Gagal');
      return false;
    } else if (jenisKelaminController.text.isEmpty) {
      VDialog.createDialog(context, message: 'Jenis kelamin wajib diisi', title: 'Gagal');
      return false;
    }
    anggota.nama = namaController.text;
    anggota.jenisKelamin = jenisKelaminController.text;
    anggota.nomorHp = nomorHpController.text;
    anggota.alamat = alamatController.text;
    anggota.tanggalLahir = tanggalLahir;
    anggota.tanggalBergabung = tanggalDaftar;
    anggota.pekerjaan = pekerjaanController.text;
    anggota.password = Anggota.defaultPassword;
    if (anggota.roles == '') anggota.roles = 'anggota';
    return true;
  }

  List<String> actionTitles() {
    if (anggota.isPengurusOnly()) {
      return ['Dismiss as pengurus', 'Delete'];
    } else if (anggota.isAnggota()) {
      return ['Set as pengurus', 'Delete'];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return ScaffoldDefault(
        textTitle: widget.anggota != null ? 'Edit Data Anggota' : 'Tambah Anggota Baru',
        body: LoadingView(),
      );
    }
    return ScaffoldDefault(
      textTitle: widget.anggota != null ? 'Edit Data Anggota' : 'Tambah Anggota Baru',
      actions: user!.isPengurus()
          ? [
              PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value == 'Delete') {
                    bool result = await VDialog.createDialog(context, message: 'Apakah anda yakin akan menghapus data anggota ${widget.anggota!.nama}?');
                    if (result) {
                      await anggota.delete();
                      Nav.pop(context, true);
                    }
                  } else if (value == 'Set as pengurus') {
                    bool result = await VDialog.createDialog(context, message: 'Apakah anda yakin menjadikan ${widget.anggota!.nama} sebagai pengurus?');
                    if (result) {
                      await anggota.setAsPengurus();
                      Nav.pop(context, true);
                    }
                  } else if (value == 'Dismiss as pengurus') {
                    bool result = await VDialog.createDialog(context, message: 'Apakah anda yakin menghapus kepengurusan ${widget.anggota!.nama}?');
                    if (result) {
                      await anggota.unsetAsPengurus();
                      Nav.pop(context, true);
                    }
                  }
                },
                itemBuilder: (BuildContext context) {
                  return actionTitles().map((String choice) {
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
            ]
          : [],
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
                  String? result = await VDialog.showListPopUp(context, tapDownDetails, ['Putra', 'Putri'], null);
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
                      tanggalLahir = Timestamp.fromDate(pickedDate);
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
                      tanggalDaftar = Timestamp.fromDate(pickedDate);
                      tanggalDaftarController.text = result;
                    });
                  }
                },
              ),
              const SizedBox(height: 15),
              FieldCustom(controller: pekerjaanController, label: 'Pekerjaan'),
              const SizedBox(height: 15),
              FieldCustom(controller: aksesController, label: 'Akses', enabled: false),
              const SizedBox(height: 30),
              Builder(builder: (context) {
                if (isLoading) {
                  return CircularProgressIndicator();
                }
                return ButtonDefault(
                  text: 'SIMPAN',
                  onPressed: () async {
                    setState(() => isLoading = true);
                    if (isValid()) {
                      if (widget.anggota != null) {
                        await Anggota.update(context, anggota);
                        setState(() => isLoading = false);
                        await VDialog.createDialog(context, message: 'Perubahan data berhasil disimpan', withBackButton: false);
                      } else {
                        bool result = await Anggota.insert(context, anggota);
                        setState(() => isLoading = false);
                        if (result) {
                          await VDialog.createDialog(context, message: 'Anggota baru berhasil ditambahkan', withBackButton: false);
                        }
                      }
                      Nav.pop(context);
                    }
                  },
                );
              }),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
