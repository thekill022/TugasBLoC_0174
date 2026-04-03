import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statemanagement/auth_event.dart';
import 'package:statemanagement/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event,
      Emitter<AuthState> emit
      ) async {
    emit(AuthLoading());
    await Future.delayed(Duration(seconds: 1));

    if(event.email.isNotEmpty && event.password.isNotEmpty) {
      emit(AuthAuthenticated(email: event.email));
    } else {
      emit(AuthError(message: "Email atau Password salah"));
    }
  }

  Future<void> _onRegisterSubmitted(
      RegisterSubmitted event,
      Emitter<AuthState> emit
      ) async {
    emit(AuthLoading());
    await Future.delayed(Duration(seconds: 1));

    if(event.email.isNotEmpty && event.password.isNotEmpty) {
      emit(AuthRegistered());
    } else {
      emit(AuthError(message: "Semua field harus diisi"));
    }
  }

  void _onLogoutRequested(
      LogoutRequested event,
      Emitter<AuthState> emit
      ) {
      emit(AuthUnauthenticated());
  }

}