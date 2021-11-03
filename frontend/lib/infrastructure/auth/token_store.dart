abstract class TokenStore {
  static const keyAccess = "accTkn";
  static const keyRefresh = "refTkn";
  Future<void> put(String key, String value);
  Future<String> get(String key);
}
