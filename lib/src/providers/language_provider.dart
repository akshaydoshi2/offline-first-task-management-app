import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_cache_provider.dart';

final languageProvider = StateProvider<Locale>((ref){
  Locale selected = const Locale('en');
  String? lang = ref.watch(cacheLanguageProvider).asData?.value;
  if((lang ?? "").isNotEmpty) return Locale(lang.toString());
  return selected;
});