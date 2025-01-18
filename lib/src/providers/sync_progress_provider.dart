import 'package:flutter_riverpod/flutter_riverpod.dart';

final syncProgressProvider = StateProvider<double>((ref){
  return 0;
});