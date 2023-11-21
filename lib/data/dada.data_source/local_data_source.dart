import 'package:ecommvvm/data/network.dart/error_handler.dart';
import 'package:ecommvvm/data/responses/responses.dart';

const CACHE_HOME_KEY = "CACHE_HOME_KEY";
const CACHE_STORES_DETAILS_KEY = "CACHE_STORES_DETAILS_KEY";

const CACHE_HOME_INTERVAL = 60 * 1000;

abstract class LocalDataSource {
  Future<HomeResponse> getHome();
  Future<StoreDetailsReponse> getStoreDetails();
  Future<void> saveStoresDetailsToCache(
      StoreDetailsReponse storeDetailsReponse);
  Future<void> saveHomeToCache(HomeResponse homeResponse);
  void clearCache();
  void removeFromCache(String key);
}

class LocalDataSourceImplementer implements LocalDataSource {
  // Runtime Cache
  Map<String, CachedItem> cachedMap = Map();
  @override
  Future<HomeResponse> getHome() async {
    CachedItem? cachedItem = cachedMap[CACHE_HOME_KEY];

    if (cachedItem != null && cachedItem.isValid(CACHE_HOME_INTERVAL)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    cachedMap[CACHE_HOME_KEY] = CachedItem(homeResponse);
  }

  @override
  void clearCache() {
    cachedMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cachedMap.remove(key);
  }

  @override
  Future<StoreDetailsReponse> getStoreDetails() async {
    CachedItem? cachedItem = cachedMap[CACHE_STORES_DETAILS_KEY];

    if (cachedItem != null && cachedItem.isValid(CACHE_HOME_INTERVAL)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveStoresDetailsToCache(
      StoreDetailsReponse storeDetailsReponse) async {
    cachedMap[CACHE_STORES_DETAILS_KEY] = CachedItem(storeDetailsReponse);
  }
}

class CachedItem {
  dynamic data;
  int cacheTime = DateTime.now().millisecondsSinceEpoch;
  CachedItem(this.data);
}

extension CachedItemExtenstion on CachedItem {
  bool isValid(int expirationTime) {
    int currentTimeInMilis = DateTime.now().millisecondsSinceEpoch;
    bool isCacheValid = (currentTimeInMilis - cacheTime) < expirationTime;
    return isCacheValid;
  }
}
