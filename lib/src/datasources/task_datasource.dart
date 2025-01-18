import 'package:hive_flutter/hive_flutter.dart';
import 'package:tushop_assesment/src/models/hive_adapters/task_adapter.dart';
import 'package:tushop_assesment/src/utilities/constants.dart';

class TaskDatasource{

  final box = Hive.box<Task>(Constants.taskBox);

  Future addTask(Task task)async{
    try{
      await box.add(task);
    }catch(e){
      throw Exception(e);
    }
  }
  
  List<Task> getTasks(){
    return box.values.toList();
  }

  Stream<List<Task>> get boxStream async* {
    yield box.values.where((e) => !e.isDeleted).toList();

    await for (final _ in box.watch()) {
      yield box.values.where((e) => !e.isDeleted).toList();
    }
  }

}