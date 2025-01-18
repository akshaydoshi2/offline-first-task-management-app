import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tushop_assesment/src/utilities/extensions.dart';
import 'package:tushop_assesment/src/widgets/language_switcher.dart';
import 'package:tushop_assesment/src/widgets/logo.dart';
import 'online_offline_switcher.dart';

Widget AppDrawer(BuildContext context, WidgetRef ref){
  return Drawer(
    child: SafeArea(
      child: Column(
        children: [
          DrawerHeader(
            child: AppLogo(context,
              titleSize: 36,
              subTitleSize: 16
            )
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: Text(context.labels.logout),
                    onTap: ()async{
                      await FirebaseAuth.instance.signOut();
                    },
                  ),
                  OnlineOfflineSwitcher(context, ref),
                  LanguageSwitcher(ref)
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}