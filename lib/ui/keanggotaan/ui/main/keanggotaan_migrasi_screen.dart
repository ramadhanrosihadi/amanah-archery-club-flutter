import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:starter_d/helper/constant/vcolor.dart';
import 'package:starter_d/helper/util/vdialog.dart';
import 'package:starter_d/helper/util/vtime.dart';
import 'package:starter_d/helper/widget/button_default.dart';
import 'package:starter_d/helper/widget/scaffold_default.dart';

import '../../../../helper/widget/default_loading.dart';
import '../../data/anggota.dart';

class KeanggotaanMigrasiScreen extends StatefulWidget {
  KeanggotaanMigrasiScreen({Key? key}) : super(key: key);

  @override
  State<KeanggotaanMigrasiScreen> createState() => _KeanggotaanMigrasiScreenState();
}

class _KeanggotaanMigrasiScreenState extends State<KeanggotaanMigrasiScreen> {
  File? fileImportExcelAnggota;
  bool isLoadingExport = false;
  bool isLoadingImport = false;

  @override
  Widget build(BuildContext context) {
    return ScaffoldDefault(
      textTitle: 'Migrasi Data Anggota',
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: Colors.grey.shade700,
                  width: 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Export Data Anggota'),
                  SizedBox(height: 10),
                  Builder(
                    builder: (context) {
                      if (isLoadingExport) return DefaultLoading(height: 40);
                      return ButtonDefault(
                        text: 'Download Data Anggota',
                        onPressed: () async {
                          setState(() => isLoadingExport = true);
                          await Anggota.downloadExcel();
                          setState(() => isLoadingExport = false);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: Colors.grey.shade700,
                  width: 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Import Data Anggota'),
                  SizedBox(height: 10),
                  Builder(builder: (context) {
                    if (fileImportExcelAnggota == null) return SizedBox();
                    return Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(child: Text(fileImportExcelAnggota!.path)),
                            SizedBox(width: 10),
                            GestureDetector(
                              child: Icon(Icons.clear),
                              onTap: () {
                                setState(() {
                                  fileImportExcelAnggota = null;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    );
                  }),
                  ButtonDefault(
                    color: Colors.black,
                    text: 'Pilih File Excel',
                    onPressed: () async {
                      FilePickerResult? result = await FilePicker.platform.pickFiles(allowedExtensions: ['xlsx'], type: FileType.custom);
                      if (result != null) {
                        if (result.files.single.path != null) {
                          setState(() {
                            fileImportExcelAnggota = File(result.files.single.path!);
                          });
                        }
                      } else {
                        VDialog.popupError(context, 'File excel tidak ditemukan');
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  Builder(
                    builder: (context) {
                      if (fileImportExcelAnggota == null) return const SizedBox();
                      if (isLoadingImport) return DefaultLoading(height: 40);
                      return ButtonDefault(
                        text: 'Import Data Anggota',
                        onPressed: () async {
                          setState(() => isLoadingImport = true);
                          var bytes = fileImportExcelAnggota!.readAsBytesSync();
                          var excel = Excel.decodeBytes(bytes);
                          Sheet sheet = excel.tables['Sheet1']!;

                          String failedNames = '';
                          int failedCount = 0;
                          int succeedCount = 0;
                          for (int rowIndex = 1; rowIndex < sheet.maxRows; rowIndex++) {
                            Anggota newAnggota = Anggota(
                              code: Anggota.numberToCode(int.tryParse(sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: rowIndex)).value.toString()) ?? 0),
                              username: sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: rowIndex)).value.toString(),
                              nama: sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: rowIndex)).value.toString(),
                              jenisKelamin: sheet.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: rowIndex)).value.toString(),
                              nomorHp: sheet.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: rowIndex)).value.toString(),
                              email: sheet.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: rowIndex)).value.toString(),
                              tanggalLahir: VTime.dateTimeStringToTimestamp(sheet.cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: rowIndex)).value.toString()),
                              roles: sheet.cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: rowIndex)).value.toString(),
                              tanggalBergabung: VTime.dateTimeStringToTimestamp(sheet.cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: rowIndex)).value.toString()),
                              pekerjaan: sheet.cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: rowIndex)).value.toString(),
                              alamat: sheet.cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: rowIndex)).value.toString(),
                              fotoProfilUrl: sheet.cell(CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: rowIndex)).value,
                            );
                            bool result = await Anggota.insert(context, newAnggota);
                            if (!result) {
                              failedNames += newAnggota.nama! + ',';
                              failedCount++;
                            } else {
                              succeedCount++;
                            }
                          }
                          setState(() => isLoadingImport = false);
                          if (failedNames != '') {
                            await VDialog.popupError(context, 'Sukses menambahkan $succeedCount data peserta.\nDan gagal menambahkan $failedCount data duplikat :\n $failedNames');
                          } else {
                            await VDialog.popupSuccess(context, 'Sukses menambahkan $succeedCount data peserta.');
                          }
                          setState(() {
                            fileImportExcelAnggota = null;
                          });
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
