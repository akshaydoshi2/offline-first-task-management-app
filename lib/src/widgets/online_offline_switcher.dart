import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tushop_assesment/src/providers/local_network_status_provider.dart';
import 'package:tushop_assesment/src/utilities/extensions.dart';

Widget OnlineOfflineSwitcher(BuildContext context, WidgetRef ref){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Text(context.labels.offline,
            style: const TextStyle(
              fontSize: 18
            ),
          ),
        ),
        const SizedBox(width: 12,),
        Switch(
          value: ref.watch(localNetworkStatusProvider),
          onChanged: (val){
            ref.read(localNetworkStatusProvider.notifier).state = val;
          }
        ),
        const SizedBox(width: 12,),
        Expanded(
          child: Text(context.labels.online,
            style: const TextStyle(
              fontSize: 18
            ),
          ),
        )
      ],
    ),
  );
}