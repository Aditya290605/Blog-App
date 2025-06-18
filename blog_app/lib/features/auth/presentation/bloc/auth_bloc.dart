import 'package:blog_app/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUsecase _signUpUsecase;
  final SignInUsecase _signInUsecase;

  AuthBloc({
    required SignUpUsecase signUpUsecase,
    required SignInUsecase signInUsecase,
  })
    // ignore: prefer_initializing_formals
    : _signUpUsecase = signUpUsecase,
       _signInUsecase = signInUsecase,
       super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      emit(AuthLoading());
      final res = await _signUpUsecase(
        SignUpParams(
          email: event.email,
          name: event.name,
          password: event.password,
        ),
      );

      res.fold(
        (l) => emit(AuthFailure(l.message)),
        (r) => emit(AuthSuccess(r)),
      );
    });

    on<AuthSignIn>((event, emit) async {
      emit(AuthLoading());
      final res = await _signInUsecase(
        SignInParams(email: event.email, password: event.password),
      );

      res.fold(
        (l) => emit(AuthFailure(l.message)),
        (r) => emit(AuthSuccess(r)),
      );
    });
  }
}
