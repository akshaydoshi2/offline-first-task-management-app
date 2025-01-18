import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:tushop_assesment/src/providers/local_network_status_provider.dart';
import 'package:tushop_assesment/src/utilities/extensions.dart';

class OnlineOfflineWidget extends ConsumerWidget {
  const OnlineOfflineWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(localNetworkStatusProvider);
    return StreamBuilder(
      stream:  InternetConnection().onStatusChange,
      builder: (context, AsyncSnapshot<InternetStatus> snapshot){
        final isOnline = status && snapshot.data == InternetStatus.connected;
        return Container(
          margin: const EdgeInsets.only(right: 16),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: isOnline ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(12)
          ),
          child: Text(isOnline ? context.labels.online : context.labels.offline,
            style: const TextStyle(
              color: Colors.white
            ),
          ),
        );
      }
    );
  }
}
