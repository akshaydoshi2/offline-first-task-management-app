import 'package:hive_flutter/hive_flutter.dart';
import 'package:tushop_assesment/src/models/hive_adapters/task_adapter.dart';

Future<int?> getIndexOfTask(Box<Task> box, String id) async {
  var objects = box.values.toList();
  for (int i = 0; i < objects.length; i++) {
    if (objects[i].id == id) {
      return i;
    }
  }
  return null;
}