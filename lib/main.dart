import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testrefrashtoken/cubit/auth_cubit.dart';
import 'package:testrefrashtoken/view/login_screen.dart';
import 'package:testrefrashtoken/service/serviceToken.dart';

void main() {
  final storage = FlutterSecureStorage();
  final dio = Dio();
  final authRepository = AuthRepository(dio: dio, storage: storage);
  
  dio.interceptors.add(AuthInterceptor(authRepository));

  runApp(MyApp(authRepository: authRepository));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;

  MyApp({required this.authRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(authRepository),
      child: MaterialApp(
        home: LoginPage(),
      ),
    );
  }
}