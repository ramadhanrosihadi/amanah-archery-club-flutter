import 'package:flutter/material.dart';
import 'package:starter_d/helper/constant/vcolor.dart';
import 'package:starter_d/helper/util/fun.dart';

class ItemInfo extends StatelessWidget {
  final String label;
  final String value;
  const ItemInfo({Key? key, required this.label, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            Fun.replaceEmpty(label),
            style: TextStyle(color: VColor.textColor.withOpacity(0.7), fontSize: 12),
          ),
          const SizedBox(height: 3),
          Text(
            Fun.replaceEmpty(value),
            style: TextStyle(color: VColor.textColor, fontSize: 17, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
