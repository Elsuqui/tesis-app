abstract class IRestProvider {
  void useAuthorizationToken(String token);
  Future<dynamic> get(String path, {Map<String, dynamic>? header});
  Future<dynamic> post(String path, Map<String, dynamic> data,
      {Map<String, dynamic>? header});
  Future<dynamic> patch(String path, Map<String, dynamic> data,
      {Map<String, dynamic>? header});
  Future<dynamic> delete(String path, {Map<String, dynamic>? header});
}
