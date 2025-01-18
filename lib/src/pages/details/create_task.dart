import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tushop_assesment/src/models/hive_adapters/task_adapter.dart';
import 'package:tushop_assesment/src/pages/details/providers/add_task_provider.dart';
import 'package:tushop_assesment/src/utilities/extensions.dart';
import 'package:tushop_assesment/src/utilities/formats.dart';
import 'package:tushop_assesment/src/widgets/app_button.dart';
import 'package:tushop_assesment/src/widgets/app_text_field.dart';

class CreateTask extends ConsumerStatefulWidget {
  final Task? task;
  const CreateTask({super.key, this.task});

  @override
  ConsumerState<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends ConsumerState<CreateTask> {

  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.task != null){
      ref.read(addTaskProvider).title = widget.task!.title;
      ref.read(addTaskProvider).description = widget.task!.description;
      if(widget.task?.taskDate != null){
        dateController.text =  Formats.formatDate(widget.task!.taskDate!);
        ref.read(addTaskProvider).taskDate = widget.task!.taskDate;
      }
      if(widget.task?.hasTime ?? false) {
        timeController.text =  Formats.formatTime(widget.task!.taskDate!);
        ref.read(addTaskProvider).hasTaskTime = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(addTaskProvider);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(context.labels.createATask,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 16,),
            AppTextField(
              initialValue: notifier.title,
              hint: context.labels.enterTaskTitle,
              validator: (v){
                return (v ?? "").isEmpty ? context.labels.titleRequired : null;
              },
              onChanged: (v){
                notifier.title = v;
                if(widget.task != null){
                  widget.task!.title = v;
                }
              },
            ),
            const SizedBox(height: 16,),
            AppTextField(
              initialValue: notifier.description,
              hint: context.labels.enterTaskDesc,
              validator: (v){
                return (v ?? "").isEmpty ? context.labels.descRequired : null;
              },
              onChanged: (v){
                notifier.description = v;
                if(widget.task != null){
                  widget.task!.description = v;
                }
              }
            ),
            const SizedBox(height: 16,),
            AppTextField(
              hint: context.labels.selectDate,
              suffix: const Icon(Icons.calendar_month),
              controller: dateController,
              readOnly: true,
              onTap: ()async{
                final date = await showDatePicker(
                  context: context,
                  initialDate: widget.task?.taskDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2050)
                );
                if(date != null){
                  notifier.taskDate = date;
                  dateController.text = Formats.formatDate(notifier.taskDate!);
                  if(widget.task != null){
                    widget.task!.taskDate = date;
                  }
                }
              },
            ),
            const SizedBox(height: 16,),
            AppTextField(
              controller: timeController,
              enabled: notifier.taskDate != null,
              hint: context.labels.selectTime,
              suffix: const Icon(Icons.access_time_outlined),
              readOnly: true,
              onTap: ()async{
                final time = await showTimePicker(
                  context: context,
                  initialTime: widget.task != null && (widget.task?.hasTime ?? false)
                      ? TimeOfDay(hour: widget.task!.taskDate!.hour, minute: widget.task!.taskDate!.minute)
                        : TimeOfDay.now(),
                );
                if(time != null){
                  notifier.taskDate = DateTime(
                    notifier.taskDate!.year,
                    notifier.taskDate!.month,
                    notifier.taskDate!.day,
                    time.hour,
                    time.minute
                  );
                  timeController.text = Formats.formatTime(notifier.taskDate!);
                  notifier.hasTaskTime = true;
                  if(widget.task != null){
                    widget.task!.taskDate = notifier.taskDate;
                  }
                }
              },
            ),
            const SizedBox(height: 24,),
            AppButton(
              onPressed: (){
                if(_formKey.currentState!.validate()){
                  if(widget.task != null){
                    widget.task!.updatedAt = DateTime.now();
                    widget.task!.save();
                    Navigator.pop(context);
                  }else{
                    notifier.addTask((){
                      Navigator.pop(context);
                    });
                  }
                }
              },
              label: widget.task == null ? context.labels.createTask : context.labels.updateTask ,
              loading: notifier.addTaskLoading,
              disabled: false,
            ),
          ],
        ),
      ),
    );
  }
}
