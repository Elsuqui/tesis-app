import 'package:dio/dio.dart';
import 'package:tesisApp/data/providers/IRestProvider.dart';

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
  Future<dynamic> get(String path, {Map<String, dynamic>? header}) async {
    // Fetch data from the network
    try {
      final response = await _dio.get(path);
      return response.data;
    } catch (e) {
      print({'Error': e});
    }
  }

  @override
  Future<dynamic> post(String path, Map<String, dynamic> data,
      {Map<String, dynamic>? header}) async {
    // Send data to the network
  }

  @override
  Future<dynamic> patch(String path, Map<String, dynamic> data,
      {Map<String, dynamic>? header}) async {
    // Send data to the network
    throw UnimplementedError('Method not implemented');
  }

  @override
  Future<dynamic> delete(String path, {Map<String, dynamic>? header}) async {
    // Send data to the network
    throw UnimplementedError('Method not implemented');
  }
}
