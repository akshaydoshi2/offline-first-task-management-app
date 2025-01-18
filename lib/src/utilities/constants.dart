import 'package:flutter/material.dart';

class Constants{
  static const language = "language";
  static const networkStatus = "networkStatus";
  static const taskBox = "taskBox";
  static const lastSyncTime = "lastSyncTime";
  static const refreshTime = 1;

  static double screenHeight(context) => MediaQuery.sizeOf(context).height - kToolbarHeight - 150.0;
}