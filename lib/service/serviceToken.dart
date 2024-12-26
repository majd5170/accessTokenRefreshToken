import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:testrefrashtoken/model/classAuthResponse.dart';
import 'package:testrefrashtoken/model/product_model.dart';

class AuthRepository {
  final Dio dio;
  final FlutterSecureStorage storage;

  AuthRepository({required this.dio, required this.storage});

  Future<AuthResponse> login(String email, String password) async {
    final response = await dio.post('http://10.207.252.142:7777/api/users-module/Authentication/login', data: {
      'email': email,
      'password': password,
    },
      options: Options(
        headers: {
          "DeviceModel" : 'Windows 10',
          "DeviceType" : 'Web',
          "DeviceOs" : 'Windows',
          "BaseDeviceId" : '3c212d88-cd4a-4593-a4b0-65859fb175a5',
          "Platform" : 'ERP CMS',
          "Version" : 'V 1.0',
        }
      )
    );
    final authResponse = AuthResponse.fromJson(response.data);
    await storage.write(key: 'accessToken', value: authResponse.token);
    await storage.write(key: 'refreshToken', value: authResponse.refreshToken);
    return authResponse;
  }

  Future<AuthResponse> refreshToken() async {
    final refreshToken = await storage.read(key: 'refreshToken');
    final response = await dio.post('http://10.207.252.142:7777/api/users-module/Authentication/login', data: {
      'refreshToken': refreshToken,
    },
    options: Options(
        headers: {
          "DeviceModel" : 'Windows 10',
          "DeviceType" : 'Web',
          "DeviceOs" : 'Windows',
          "BaseDeviceId" : '3c212d88-cd4a-4593-a4b0-65859fb175a5',
          "Platform" : 'ERP CMS',
          "Version" : 'V 1.0',
        }
      )
    );
    final authResponse = AuthResponse.fromJson(response.data);
    await storage.write(key: 'accessToken', value: authResponse.token);
    return authResponse;
  }
}

// 

class AuthInterceptor extends Interceptor {
  final AuthRepository authRepository;
  AuthInterceptor(this.authRepository);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await authRepository.storage.read(key: 'accessToken');
    if (accessToken != null) {
      options.headers['authorization'] = '$accessToken';
    }
    return super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        await authRepository.refreshToken();
        final accessToken = await authRepository.storage.read(key: 'accessToken');
        final options = err.response!.requestOptions;
        options.headers['authorization'] = '$accessToken';
        final response = await authRepository.dio.fetch(options);
        return handler.resolve(response);
      } catch (e) {
        return handler.reject(err);
      }
    }
    return super.onError(err, handler);
  }
}



class ApiService {
  final AuthRepository authRepository;
  ApiService(this.authRepository);

  final Dio _dio = Dio();
  Future<List<ProductModel>> fetchUsers() async {
    try {
      final accessToken = await authRepository.storage.read(key: 'accessToken');
      final response = await _dio.post('http://10.207.252.138:9091/api/fms-module/VehicleTypes/search' ,
     options: Options(
        headers: {
          "DeviceModel" : 'Windows 10',
          "DeviceType" : 'Web',
          "DeviceOs" : 'Windows',
          "BaseDeviceId" : '3c212d88-cd4a-4593-a4b0-65859fb175a5',
          "Platform" : 'ERP CMS',
          "Version" : 'V 1.0',
          "authorization": '$accessToken'
        }
      )
      );
      if (response.statusCode == 200) {
      List<ProductModel> data = (response.data['data'] as  List<dynamic>).map((user) => ProductModel.fromJson(user)).toList();
      print(response.data);
      return data;
  
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
      throw Exception('Error: $e');
    }
  }
}