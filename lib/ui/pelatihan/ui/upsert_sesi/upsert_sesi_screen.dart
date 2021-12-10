import 'package:flutter/material.dart';
import 'package:starter_d/helper/util/fun.dart';
import 'package:starter_d/helper/widget/button_default.dart';
import 'package:starter_d/helper/widget/field_custom.dart';
import 'package:starter_d/helper/widget/scaffold_default.dart';

class UpsertSesiScreen extends StatefulWidget {
  UpsertSesiScreen({Key? key}) : super(key: key);

  @override
  _UpsertSesiScreenState createState() => _UpsertSesiScreenState();
}

class _UpsertSesiScreenState extends State<UpsertSesiScreen> {
  TextEditingController tanggalController = TextEditingController();
  TextEditingController waktuController = TextEditingController();
  TextEditingController catatanController = TextEditingController();
  DateTime? waktuLatihan;
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
                      if (waktuLatihan != null) {
                        defaultDate = waktuLatihan!;
                      }
                      waktuLatihan = DateTime(defaultDate.year, defaultDate.month, defaultDate.day, defaultDate.hour, defaultDate.minute);
                      tanggalController.text = result;
                    });
                  }
                },
              ),
              const SizedBox(height: 15),
              FieldCustom(
                controller: waktuController,
                label: 'Jam Latihan',
                onTapDown: (TapDownDetails tapDownDetails) async {
                  Fun.closeKeyboard(context);
                  final TimeOfDay? result = await showTimePicker(
                    initialTime: TimeOfDay.now(),
                    context: context,
                  );
                  if (result != null) {
                    setState(() {
                      DateTime defaultDate = DateTime.now();
                      if (waktuLatihan != null) {
                        defaultDate = waktuLatihan!;
                      }
                      waktuLatihan = DateTime(defaultDate.year, defaultDate.month, defaultDate.day, result.hour, result.minute);
                      waktuController.text = result.format(context);
                    });
                  }
                },
              ),
              const SizedBox(height: 15),
              FieldCustom(
                controller: catatanController,
                label: 'Catatan',
                textInputType: TextInputType.multiline,
              ),
              const SizedBox(height: 25),
              ButtonDefault(
                text: 'BUAT BARU',
                onPressed: () async {},
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
