import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:tushop_assesment/src/models/hive_adapters/task_adapter.dart';
import 'package:tushop_assesment/src/pages/details/create_task.dart';
import 'package:tushop_assesment/src/pages/details/details_screen.dart';
import 'package:tushop_assesment/src/utilities/app_colors.dart';
import 'package:tushop_assesment/src/utilities/extensions.dart';
import 'package:tushop_assesment/src/utilities/formats.dart';

class TaskWidget extends StatelessWidget {
  final Task task;
  const TaskWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(task.id),
      startActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12)
            ),
            onPressed: (context)async{
              task.isDone = !task.isDone;
              task.updatedAt = DateTime.now();
              await task.save();
            },
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            icon: task.isDone ? Icons.remove_circle_outline : Icons.check_circle_outline,
            label: task.isDone ? context.labels.undone : context.labels.done,
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            padding: EdgeInsets.zero,
            onPressed: (context){
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(context.labels.areYouSure),
                    content: Text(context.labels.areYouSureDelete),
                    actions: [
                      ElevatedButton(
                        onPressed: ()async{
                          task.isDeleted = true;
                          await task.save();
                          Navigator.pop(context);
                        },
                        child: Text(context.labels.delete)
                      ),
                      ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text(context.labels.cancel)
                      )
                    ],
                  );
                }
              );
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: context.labels.delete,
          ),
          SlidableAction(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12)
            ),
            onPressed: (context){
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return CreateTask(
                    task: task,
                  );
                }
              );
            },
            backgroundColor: Colors.amber,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: context.labels.edit,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryBg,
          borderRadius: BorderRadius.circular(12)
        ),
        child: ListTile(
          onTap: (){
            showDialog(
              context: context,
              builder: (context) => Dialog(
                child: TaskDetails(task: task),
              )
            );
          },
          trailing: task.syncDateTime != null ? const Icon(Icons.cloud_sync_outlined, color: AppColors.primary,) : null,
          leading: task.isDone ? const Icon(Icons.check_circle_outline, color: AppColors.primary,) : null,
          title: Text(task.title),
          subtitle: task.taskDate == null ? Text(task.description) : Text((task.hasTime ?? false) ? Formats.formatDatetime(task.taskDate!) : Formats.formatDate(task.taskDate!)),
        ),
      ),
    );
  }
}
