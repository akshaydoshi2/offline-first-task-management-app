import 'package:flutter_riverpod/flutter_riverpod.dart';

final syncLoadingProvider = StateProvider<bool>((ref){
  return false;
});