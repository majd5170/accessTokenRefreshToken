import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:testrefrashtoken/model/classAuthResponse.dart';
import 'package:testrefrashtoken/service/serviceToken.dart';

part 'auth_state.dart';


class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());

  Future<void> login(String username, String password) async {
    try {
      emit(AuthLoading());
      final authResponse = await authRepository.login(username, password);
      emit(AuthAuthenticated(authResponse));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> refresh() async {
    try {
      emit(AuthLoading());
      final authResponse = await authRepository.refreshToken();
      emit(AuthAuthenticated(authResponse));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}