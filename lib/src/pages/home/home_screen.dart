import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tushop_assesment/src/pages/details/create_task.dart';
import 'package:tushop_assesment/src/pages/home/widgets/online_offline_widget.dart';
import 'package:tushop_assesment/src/pages/home/widgets/task_widget.dart';
import 'package:tushop_assesment/src/providers/app_cache_provider.dart';
import 'package:tushop_assesment/src/providers/sync_loading_provider.dart';
import 'package:tushop_assesment/src/providers/sync_progress_provider.dart';
import 'package:tushop_assesment/src/providers/tasks_provider.dart';
import 'package:tushop_assesment/src/utilities/app_colors.dart';
import 'package:tushop_assesment/src/utilities/constants.dart';
import 'package:tushop_assesment/src/utilities/extensions.dart';
import 'package:tushop_assesment/src/utilities/formats.dart';
import 'package:tushop_assesment/src/utilities/sync_service.dart';
import 'package:tushop_assesment/src/widgets/app_drawer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(minutes: Constants.refreshTime), (timer) async {
      SyncService(
        hiveBox: Hive.box(Constants.taskBox),
        firestore: FirebaseFirestore.instance,
        ref: ref,
        context: context
      ).syncTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text(context.labels.taskManager),
        actions: const [
          OnlineOfflineWidget()
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16,),
          if(ref.watch(syncLoadingProvider))
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: LinearProgressIndicator(
              backgroundColor: AppColors.primaryBg,
              value: ref.watch(syncProgressProvider),
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
          const SizedBox(height: 16,),
          ref.watch(lastSyncTimeProvider).when(
            data: (data){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text("${context.labels.lastSynced} ${data == null ? "--" : Formats.formatDatetime(data)}",),
              );
            },
            error: (e,s) => const SizedBox(),
            loading: () => const SizedBox()
          ),
          const SizedBox(height: 16,),
          ref.watch(taskStreamProvider).when(
            data: (data){
              if(data.isEmpty) {
                return SizedBox(
                  height: Constants.screenHeight(context),
                  child: Center(
                    child: Text(context.labels.addTasksToContinue,
                      style: const TextStyle(
                        color: Colors.black38
                      ),
                    )
                  ),
                );
              }
              data.sort((a,b) => b.updatedAt.compareTo(a.updatedAt));
              return ListView.separated(
                shrinkWrap: true,
                itemCount: data.length,
                padding: const EdgeInsets.all(16),
                separatorBuilder: (context, index){
                  return const SizedBox(height: 16,);
                },
                itemBuilder: (context, index){
                  final task = data[index];
                  return TaskWidget(task: task,);
                },
              );
            },
            error: (e,s){
              return SizedBox(
                height: MediaQuery.sizeOf(context).height,
                child: Center(child: Text(context.labels.somethingWentWrong))
              );
            },
            loading: () => const Center(child: CircularProgressIndicator(),)
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(context.labels.add),
        onPressed: (){
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return const CreateTask();
            }
          );
        },
        icon: const Icon(Icons.add),
      ),
      drawer: AppDrawer(context, ref),
    );
  }
}
