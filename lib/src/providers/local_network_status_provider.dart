import 'package:flutter_riverpod/flutter_riverpod.dart';

final localNetworkStatusProvider = StateProvider<bool>((ref){
  return true;
});