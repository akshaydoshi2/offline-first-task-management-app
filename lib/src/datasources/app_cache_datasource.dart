import 'package:shared_preferences/shared_preferences.dart';
import 'package:tushop_assesment/src/utilities/constants.dart';

class AppCacheDatasource{
  Future<String?> getLang()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.language);
  }

  Future<void> setLang(String lang)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.language, lang);
    return;
  }

  Future<DateTime?> getLastSyncTime()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(!prefs.containsKey(Constants.lastSyncTime)) return null;

    return DateTime.parse(prefs.getString(Constants.lastSyncTime)!);
  }
}