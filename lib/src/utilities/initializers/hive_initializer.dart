import 'package:hive_flutter/hive_flutter.dart';
import 'package:tushop_assesment/src/models/hive_adapters/task_adapter.dart';
import 'package:tushop_assesment/src/utilities/constants.dart';

class HiveInitializer{
  static init()async{
    //Initialize hive_flutter
    await Hive.initFlutter();
    //Initialize TaskAdaprt
    Hive.registerAdapter(TaskAdapter());
    //Open hive box
    await Hive.openBox<Task>(Constants.taskBox);
  }
}