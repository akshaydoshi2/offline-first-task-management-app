import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tushop_assesment/src/datasources/app_cache_datasource.dart';

final appCacheProvider = Provider((ref) => AppCacheProvider(ref));
final cacheLanguageProvider = FutureProvider((ref) => ref.read(appCacheProvider).getLang());
final lastSyncTimeProvider = FutureProvider((ref) => ref.read(appCacheProvider).getLastSyncTime());

class AppCacheProvider {
  final Ref ref;
  AppCacheProvider(this.ref);

  final AppCacheDatasource _appCacheDataSource = AppCacheDatasource();

  Future<String> getLang()async{
    return await _appCacheDataSource.getLang() ?? "";
  }

  Future<void> setLang(String lang)async{
    await _appCacheDataSource.setLang(lang);
  }

  Future<DateTime?> getLastSyncTime()async{
    return await _appCacheDataSource.getLastSyncTime();
  }
}