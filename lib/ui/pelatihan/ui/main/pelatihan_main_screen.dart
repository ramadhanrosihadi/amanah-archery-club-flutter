import 'package:flutter/material.dart';
import 'package:starter_d/helper/util/nav.dart';
import 'package:starter_d/helper/widget/coming_soon.dart';
import 'package:starter_d/helper/widget/scaffold_default.dart';
import 'package:starter_d/ui/pelatihan/ui/upsert_sesi/upsert_sesi_screen.dart';

class PelatihanMainScreen extends StatefulWidget {
  PelatihanMainScreen({Key? key}) : super(key: key);

  @override
  _PelatihanMainScreenState createState() => _PelatihanMainScreenState();
}

class _PelatihanMainScreenState extends State<PelatihanMainScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldDefault(
      textTitle: 'Sesi Latihan',
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Nav.push(context, UpsertSesiScreen());
        },
        child: const Icon(Icons.add),
      ),
      body: const ComingSoon(
        message: 'List Sesi Latihan',
      ),
    );
  }
}
