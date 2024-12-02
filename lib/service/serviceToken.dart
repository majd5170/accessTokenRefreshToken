import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:testrefrashtoken/model/classAuthResponse.dart';

class AuthRepository {
  final Dio dio;
  final FlutterSecureStorage storage;

  AuthRepository({required this.dio, required this.storage});

  Future<AuthResponse> login(String username, String password) async {
    final response = await dio.post('https://dummyjson.com/auth/login', data: {
      'username': username,
      'password': password,
    });
    final authResponse = AuthResponse.fromJson(response.data);
    await storage.write(key: 'accessToken', value: authResponse.accessToken);
    await storage.write(key: 'refreshToken', value: authResponse.refreshToken);
    return authResponse;
  }

  Future<AuthResponse> refreshToken() async {
    final refreshToken = await storage.read(key: 'refreshToken');
    final response = await dio.post('https://dummyjson.com/auth/refresh', data: {
      'refreshToken': refreshToken,
    });
    final authResponse = AuthResponse.fromJson(response.data);
    await storage.write(key: 'accessToken', value: authResponse.accessToken);
    return authResponse;
  }
}

class AuthInterceptor extends Interceptor {
  final AuthRepository authRepository;

  AuthInterceptor(this.authRepository);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await authRepository.storage.read(key: 'accessToken');
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    return super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Token expired, try to refresh
      try {
        await authRepository.refreshToken();
        final accessToken = await authRepository.storage.read(key: 'accessToken');
        // Retry the request with the new token
        final options = err.response!.requestOptions;
        options.headers['Authorization'] = 'Bearer $accessToken';
        final response = await authRepository.dio.fetch(options);
        return handler.resolve(response);
      } catch (e) {
        return handler.reject(err);
      }
    }
    return super.onError(err, handler);
  }
}

