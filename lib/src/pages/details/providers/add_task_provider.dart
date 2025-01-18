import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tushop_assesment/src/models/hive_adapters/task_adapter.dart';
import 'package:tushop_assesment/src/providers/tasks_provider.dart';
import 'package:uuid/uuid.dart';

final addTaskProvider = ChangeNotifierProvider((ref)=> AddTaskNotifierProvider(ref));

class AddTaskNotifierProvider extends ChangeNotifier{
  Ref _ref;
  AddTaskNotifierProvider(this._ref);

  Uuid get uuid => const Uuid();

  String? _title;
  String? get title => _title;
  set title(String? v){
    _title = v;
    notifyListeners();
  }

  String? _description;
  String? get description => _description;
  set description(String? v){
    _description = v;
    notifyListeners();
  }

  DateTime? _taskDate;
  DateTime? get taskDate => _taskDate;
  set taskDate(DateTime? v){
    _taskDate = v;
    notifyListeners();
  }

  bool? _hasTaskTime;
  bool? get hasTaskTime => _hasTaskTime;
  set hasTaskTime(bool? v){
    _hasTaskTime = v;
    notifyListeners();
  }

  bool _addTaskLoading = false;
  bool get addTaskLoading => _addTaskLoading;
  set addTaskLoading(bool v){
    _addTaskLoading = v;
    notifyListeners();
  }

  addTask(VoidCallback onDone)async{
    addTaskLoading = true;
    final task = Task(
      id: uuid.v4(),
      title: title!,
      description: description!,
      taskDate: taskDate,
      hasTime: hasTaskTime ?? false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    _ref.read(newTaskProvider(task));
    addTaskLoading = false;
    onDone();
    clear();
  }

  clear(){
    title = null;
    description = null;
    taskDate = null;
    notifyListeners();
  }

}