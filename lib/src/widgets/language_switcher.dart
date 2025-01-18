import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tushop_assesment/src/providers/app_cache_provider.dart';
import 'package:tushop_assesment/src/providers/language_provider.dart';

Widget LanguageSwitcher(WidgetRef ref){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text("English",
        style: TextStyle(
          fontSize: 18
        ),
      ),
      const SizedBox(width: 12,),
      Switch(
        value: ref.watch(languageProvider).languageCode == 'sw',
        onChanged: (val){
          if(val){
            ref.read(languageProvider.notifier).state = const Locale('sw');
            ref.read(appCacheProvider).setLang('sw');
          }else{
            ref.read(languageProvider.notifier).state = const Locale('en');
            ref.read(appCacheProvider).setLang('en');
          }
        }
      ),
      const SizedBox(width: 12,),
      const Text("Swahili",
        style: TextStyle(
          fontSize: 18
        ),
      )
    ],
  );
}