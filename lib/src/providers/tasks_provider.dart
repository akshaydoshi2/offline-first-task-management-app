import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tushop_assesment/src/datasources/task_datasource.dart';
import 'package:tushop_assesment/src/models/hive_adapters/task_adapter.dart';

final taskProvider = Provider((ref) => TasksProvider(ref));

final newTaskProvider = FutureProvider.family<void, Task>((ref, Task task) async {
  await ref.read(taskProvider).addTask(task);
});

final taskStreamProvider = StreamProvider<List<Task>>((ref) {
  return ref.read(taskProvider).boxStream();
});

class TasksProvider {
  final Ref ref;
  TasksProvider(this.ref);

  final TaskDatasource _tasksDataSource = TaskDatasource();

  Future<void> addTask(Task task) async {
    try {
      await _tasksDataSource.addTask(task);
    } catch (e) {
      throw Exception('Failed to add task: $e');
    }
  }

  Stream<List<Task>> boxStream (){
    return _tasksDataSource.boxStream;
  }
}