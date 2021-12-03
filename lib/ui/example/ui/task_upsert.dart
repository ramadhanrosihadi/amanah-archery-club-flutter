import 'package:flutter/material.dart';

import 'package:starter_d/ui/example/data/task.dart';

class TaskUpsert extends StatefulWidget {
  TaskUpsert({Key? key, this.task}) : super(key: key);
  final Task? task;

  @override
  _TaskUpsertState createState() => _TaskUpsertState();
}

class _TaskUpsertState extends State<TaskUpsert> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.task != null ? widget.task!.name : 'New Task')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
