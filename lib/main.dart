import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tushop_assesment/src/app.dart';
import 'package:tushop_assesment/src/utilities/initializers/hive_initializer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await HiveInitializer.init();
  runApp(
    const ProviderScope(
      child: MyApp()
    )
  );
}
