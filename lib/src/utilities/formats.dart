import 'package:intl/intl.dart';

class Formats{
  static String formatDatetime(DateTime dateTime){
    return DateFormat("dd MMM yyyy hh:mm aa").format(dateTime);
  }

  static String formatDate(DateTime dateTime){
    return DateFormat("dd MMM yyyy").format(dateTime);
  }

  static String formatTime(DateTime dateTime){
    return DateFormat("hh:mm aa").format(dateTime);
  }
}