import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:starter_d/helper/util/nav.dart';
import 'package:starter_d/helper/widget/coming_soon.dart';
import 'package:starter_d/helper/widget/loading_view.dart';
import 'package:starter_d/helper/widget/scaffold_default.dart';
import 'package:starter_d/ui/pelatihan/data/sesi.dart';
import 'package:starter_d/ui/pelatihan/ui/detail_sesi/detail_sesi_screen.dart';
import 'package:starter_d/ui/pelatihan/ui/main/widgets/item_sesi.dart';
import 'package:starter_d/ui/pelatihan/ui/upsert_sesi/upsert_sesi_screen.dart';

class PelatihanMainScreen extends StatefulWidget {
  PelatihanMainScreen({Key? key}) : super(key: key);

  @override
  _PelatihanMainScreenState createState() => _PelatihanMainScreenState();
}

class _PelatihanMainScreenState extends State<PelatihanMainScreen> {
  @override
  Widget build(BuildContext context) {
    Query<Map<String, dynamic>> datas = FirebaseFirestore.instance.collection('sesis');
    return ScaffoldDefault(
      textTitle: 'Sesi Latihan',
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Nav.push(context, UpsertSesiScreen());
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: datas.snapshots(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            List<Sesi> datas = Sesi.getDataFromSnapshot(snapshot.data);
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
                            Nav.push(context, DetailSesiScreen(sesi: datas[index]));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: ItemSesi(data: datas[index]),
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
