import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:starter_d/data/network/data/network_request_data.dart';
import 'package:starter_d/data/network/data/network_response_data.dart';
import 'package:starter_d/data/network/network_call.dart';
import 'package:starter_d/helper/constant/urls.dart';
import 'package:starter_d/helper/util/fun.dart';
import 'package:starter_d/helper/util/nav.dart';
import 'package:starter_d/helper/widget/custom_future_builder.dart';
import 'package:starter_d/ui/example/data/task.dart';
import 'package:starter_d/ui/example/ui/task_upsert.dart';

class TaskList extends StatefulWidget {
  TaskList({Key? key}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Nav.push(context, TaskUpsert());
        },
        child: const Icon(Icons.add),
      ),
      body: CustomFutureBuilder(
        reload: () => setState(() {}),
        url: Urls.taskAll,
        buildSuccess: (result) {
          List<Task> datas = Task.fromListDynamic(result);
          if (datas.length == 0) {
            return const Center(child: Text('Data tidak ditemukan'));
          }
          return ListView.separated(
            itemBuilder: (context, index) {
              Task data = datas[index];
              return ListTile(
                title: Text('${index + 1}. ${data.name}'),
                subtitle: Text(data.description),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: datas.length,
          );
        },
      ),
    );
  }
}
