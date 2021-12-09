import 'package:flutter/material.dart';
import 'package:starter_d/helper/util/nav.dart';
import 'package:starter_d/helper/widget/coming_soon.dart';
import 'package:starter_d/ui/keanggotaan/ui/upsert/keanggotaan_upsert_screen.dart';

class KeanggotaanMainScreen extends StatefulWidget {
  KeanggotaanMainScreen({Key? key}) : super(key: key);

  @override
  _KeanggotaanMainScreenState createState() => _KeanggotaanMainScreenState();
}

class _KeanggotaanMainScreenState extends State<KeanggotaanMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Nav.push(context, KeanggotaanUpsertScreen());
        },
        child: const Icon(Icons.add),
      ),
      body: const ComingSoon(
        message: 'List Anggota Klub',
      ),
    );
  }
}
