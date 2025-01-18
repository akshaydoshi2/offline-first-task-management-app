import 'package:flutter/material.dart';
import 'package:tushop_assesment/src/models/hive_adapters/task_adapter.dart';
import 'package:tushop_assesment/src/utilities/app_colors.dart';
import 'package:tushop_assesment/src/utilities/extensions.dart';
import 'package:tushop_assesment/src/utilities/formats.dart';

class TaskDetails extends StatelessWidget {
  final Task task;
  const TaskDetails({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(16),
      children: [
        const Text("Task Details",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 8,),
        const Divider(),
        const SizedBox(height: 8,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(task.title,
                style: const TextStyle(
                  fontSize: 32,
                  color: AppColors.primary
                ),
              )
            ),
            const SizedBox(width: 16,),
            if(task.isDone)
            const Icon(Icons.check_circle_outline,
              color: AppColors.primary,
            )
          ],
        ),
        const SizedBox(height: 16,),
        Text(task.description,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 16,),
        if(task.taskDate != null)
        Text((task.hasTime ?? false) ? Formats.formatDatetime(task.taskDate!) : Formats.formatDate(task.taskDate!)),
        if(task.syncDateTime != null)
        const SizedBox(height: 16,),
        if(task.syncDateTime != null)
        Text("Synced on: ${Formats.formatDatetime(task.syncDateTime!)}"),
        const SizedBox(height: 32,),
        ElevatedButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text(context.labels.close)
        )
      ],
    );
  }
}
