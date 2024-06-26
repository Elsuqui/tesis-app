import 'package:dio/dio.dart';
import 'package:tesisApp/data/dto/rest_response.dto.dart';
import 'package:tesisApp/data/providers/rest.interface.dart';

class DioRestProvider implements IRestProvider {
  final Dio _dio = Dio();

  DioRestProvider({
    required String baseUrl,
  }) {
    _dio.options.baseUrl = baseUrl;
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  @override
  useAuthorizationToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  @override
  Future<RestResponse> get(String path, {Map<String, dynamic>? header}) async {
    // Fetch data from the network
    try {
      final response = await _dio.get(path, options: Options(headers: header));
      return RestResponse.fromJson({
        'data': response.data,
        'statusCode': response.statusCode,
      });
    } on DioException catch (e) {
      return RestResponse.fromJson({
        'data': null,
        'statusCode': e.response?.statusCode ?? 500,
        'errorMessage': e.toString(),
      });
    }
  }

  @override
  Future<RestResponse> post(String path, Map<String, dynamic> data,
      {Map<String, dynamic>? header}) async {
    // Send data to the network
    try {
      final response =
          await _dio.post(path, data: data, options: Options(headers: header));
      return RestResponse.fromJson({
        'data': response.data,
        'statusCode': response.statusCode,
      });
    } on DioException catch (e) {
      return RestResponse.fromJson({
        'data': null,
        'statusCode': e.response?.statusCode ?? 500,
        'errorMessage': e.toString(),
      });
    }
  }

  @override
  Future<RestResponse> patch(String path, Map<String, dynamic> data,
      {Map<String, dynamic>? header}) async {
    // Send data to the network
    try {
      final response =
          await _dio.patch(path, data: data, options: Options(headers: header));
      return RestResponse.fromJson({
        'data': response.data,
        'statusCode': response.statusCode,
      });
    } on DioException catch (e) {
      return RestResponse.fromJson({
        'data': null,
        'statusCode': e.response?.statusCode ?? 500,
        'errorMessage': e.toString(),
      });
    }
  }

  @override
  Future<RestResponse> delete(String path,
      {Map<String, dynamic>? header}) async {
    // Send data to the network
    try {
      final response =
          await _dio.delete(path, options: Options(headers: header));
      return RestResponse.fromJson({
        'data': response.data,
        'statusCode': response.statusCode,
      });
    } on DioException catch (e) {
      return RestResponse.fromJson({
        'data': null,
        'statusCode': e.response?.statusCode ?? 500,
        'errorMessage': e.toString(),
      });
    }
  }
}
