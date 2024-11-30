class SharedPreferencesHelper {
  static const String _accessTokenKey = "accessToken";
  static const String _hardCodedToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJtZW1iZXJJZCI6NCwibWVtYmVyTmFtZSI6InZlZW4wMjE5QG5hdmVyLmNvbSIsImlhdCI6MTczMjg2ODEwNX0.AE6vDREPlAkDhizgodtqiwsVSL43epjcxk1J3HFokQ8"; // 하드코딩된 토큰

  static Future<String?> getAccessToken() async {
    return _hardCodedToken; // 항상 하드코딩된 값을 반환
  }

  static Future<void> saveAccessToken(String token) async {}
  static Future<void> removeAccessToken() async {}
}
