import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:starter_d/helper/util/nav.dart';
import 'package:starter_d/helper/widget/coming_soon.dart';
import 'package:starter_d/helper/widget/loading_view.dart';
import 'package:starter_d/helper/widget/scaffold_default.dart';
import 'package:starter_d/ui/keanggotaan/data/anggota.dart';
import 'package:starter_d/ui/keanggotaan/ui/main/keanggotaan_migrasi_screen.dart';
import 'package:starter_d/ui/keanggotaan/ui/main/widgets/item_anggota.dart';
import 'package:starter_d/ui/keanggotaan/ui/upsert/keanggotaan_upsert_screen.dart';

import '../../../../data/preference/user_pref.dart';
import '../../../../helper/constant/vcolor.dart';
import '../../../../helper/util/vdialog.dart';

class KeanggotaanMainScreen extends StatefulWidget {
  KeanggotaanMainScreen({Key? key}) : super(key: key);

  @override
  _KeanggotaanMainScreenState createState() => _KeanggotaanMainScreenState();
}

class _KeanggotaanMainScreenState extends State<KeanggotaanMainScreen> {
  Anggota? user;
  List<String> actionTitles = ['Migrasi Excel'];

  @override
  void initState() {
    super.initState();
    UserPref.loadUser().then((value) {
      setState(() {
        user = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Query<Map<String, dynamic>> jamaahs = FirebaseFirestore.instance.collection('anggotas');
    return ScaffoldDefault(
      textTitle: 'List Anggota Klub',
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Nav.push(context, KeanggotaanUpsertScreen());
        },
        child: const Icon(Icons.add),
      ),
      actions: user != null && user!.isPengurus()
          ? [
              PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value == 'Migrasi Excel') {
                    Nav.push(context, KeanggotaanMigrasiScreen());
                  }
                },
                itemBuilder: (BuildContext context) {
                  return actionTitles.map((String choice) {
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
      body: StreamBuilder<QuerySnapshot>(
        stream: jamaahs.snapshots(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            List<Anggota> datas = Anggota.getDataFromSnapshot(snapshot.data);
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    ListView.builder(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Nav.push(context, KeanggotaanUpsertScreen(anggota: datas[index]));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: ItemAnggota(anggota: datas[index]),
                          ),
                        );
                      },
                      itemCount: datas.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          }
          return const LoadingView();
        },
      ),
    );
  }
}
