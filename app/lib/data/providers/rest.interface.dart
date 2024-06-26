import 'package:tesisApp/data/dto/rest_response.dto.dart';

abstract class IRestProvider {
  void useAuthorizationToken(String token);
  Future<RestResponse> get(String path, {Map<String, dynamic>? header});
  Future<RestResponse> post(String path, Map<String, dynamic> data,
      {Map<String, dynamic>? header});
  Future<RestResponse> patch(String path, Map<String, dynamic> data,
      {Map<String, dynamic>? header});
  Future<RestResponse> delete(String path, {Map<String, dynamic>? header});
}
