import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tushop_assesment/src/models/hive_adapters/task_adapter.dart';
import 'package:tushop_assesment/src/providers/app_cache_provider.dart';
import 'package:tushop_assesment/src/providers/local_network_status_provider.dart';
import 'package:tushop_assesment/src/providers/sync_loading_provider.dart';
import 'package:tushop_assesment/src/providers/sync_progress_provider.dart';
import 'package:tushop_assesment/src/utilities/constants.dart';
import 'package:tushop_assesment/src/utilities/extensions.dart';
import 'package:tushop_assesment/src/utilities/formats.dart';
import 'package:tushop_assesment/src/utilities/methods.dart';

class SyncService{
  final Box<Task> hiveBox;
  final FirebaseFirestore firestore;
  final WidgetRef ref;
  final BuildContext context;

  SyncService({required this.hiveBox, required this.firestore, required this.ref, required this.context});

  Future<void> syncTasks() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    ref.read(syncLoadingProvider.notifier).state = true;
    final network = await InternetConnection().hasInternetAccess;
    final localNetworkStatus = ref.read(localNetworkStatusProvider);
    if(!(network && localNetworkStatus)){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.labels.syncAborted))
      );
      ref.read(syncLoadingProvider.notifier).state = false;
      return;
    }
    ref.read(syncProgressProvider.notifier).state = 0.1;
    await Future.delayed(const Duration(milliseconds: 100));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.labels.syncInitiated))
    );

    final now = DateTime.now();
    final sharedPrefs = await SharedPreferences.getInstance();
    final lastSyncTime = sharedPrefs.getString(Constants.lastSyncTime);
    DateTime? lastSyncDateTime = lastSyncTime != null ? DateTime.parse(lastSyncTime) : null;

    // Handle first-time sync
    ref.read(syncProgressProvider.notifier).state = 0.2;
    await Future.delayed(const Duration(milliseconds: 100));
    if (lastSyncDateTime == null) {
      final firestoreTasks = await firestore.collection(uid).get();
      for (final doc in firestoreTasks.docs) {
        final task = Task.fromFirestoreMap(doc.data());
        await hiveBox.add(task);
      }
      // sharedPrefs.setString(Constants.lastSyncTime, now.toIso8601String());
      lastSyncDateTime = now;
      // ref.invalidate(lastSyncTimeProvider);
      // ref.read(syncProgressProvider.notifier).state = 1;
      // ref.read(syncLoadingProvider.notifier).state = false;
      // return;
    }

    // Step 1: Push local updates (including deletions)
    final localTasks = hiveBox.values.where((task) {
      return task.syncDateTime == null || task.updatedAt.isAfter(task.syncDateTime!);
    }).toList();
    ref.read(syncProgressProvider.notifier).state = 0.3;
    await Future.delayed(const Duration(milliseconds: 100));

    final batch = firestore.batch();
    for (final task in localTasks) {
      final taskDoc = firestore.collection(uid).doc(task.id);

      if (task.isDeleted) {
        // Task marked for deletion
        final docSnapshot = await taskDoc.get();
        if (docSnapshot.exists) {
          batch.delete(taskDoc);
        }
      } else {
        // Task to be updated or created
        batch.set(taskDoc, task.toFirestoreMap());
        task.syncDateTime = now;
      }
    }
    ref.read(syncProgressProvider.notifier).state = 0.4;
    await Future.delayed(const Duration(milliseconds: 100));
    await batch.commit();

    // Save updated syncDateTime for non-deleted tasks
    for (final task in localTasks.where((task) => !task.isDeleted)) {
      await task.save();
    }

    // Remove deleted tasks from Hive
    for (final task in localTasks.where((task) => task.isDeleted)) {
      await hiveBox.delete(task.id);
    }
    ref.read(syncProgressProvider.notifier).state = 0.5;
    await Future.delayed(const Duration(milliseconds: 100));

    // Step 2: Pull remote updates
    final firestoreTasks = await firestore
        .collection(uid)
        .where('updatedAt', isGreaterThan: lastSyncDateTime)
        .get();

    ref.read(syncProgressProvider.notifier).state = 0.6;
    await Future.delayed(const Duration(milliseconds: 100));

    for (final doc in firestoreTasks.docs) {
      final taskData = doc.data();
      final localTask = hiveBox.get(taskData['id']);

      if (localTask == null || taskData['updatedAt'].toDate().isAfter(localTask.updatedAt)) {
        final mergedTask = Task.fromFirestoreMap(taskData);

        if (mergedTask.isDeleted) {
          // If remote task is marked as deleted, remove it locally
          await hiveBox.delete(mergedTask.id);
        } else {
          // Otherwise, update or add the task locally
          mergedTask.syncDateTime = now;
          final indexOfTask = await getIndexOfTask(hiveBox, taskData['id']);
          if(indexOfTask != null){
            await hiveBox.putAt(indexOfTask, mergedTask);
          }
        }
      }
    }
    ref.read(syncProgressProvider.notifier).state = 0.7;
    await Future.delayed(const Duration(milliseconds: 100));

    // Step 3: Update last sync time and update sync progress state
    ref.read(syncProgressProvider.notifier).state = 1;
    sharedPrefs.setString(Constants.lastSyncTime, now.toIso8601String());
    ref.invalidate(lastSyncTimeProvider);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${context.labels.syncComplete} ${Formats.formatDatetime(now)}"))
    );
    ref.read(syncLoadingProvider.notifier).state = false;
  }
}