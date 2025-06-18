import 'package:blog_app/core/usecase/use_case_interface.dart';
import 'package:blog_app/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/user_auth_state.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUsecase _signUpUsecase;
  final SignInUsecase _signInUsecase;
  final UserAuthState _userCurrentLogin;

  AuthBloc({
    required SignUpUsecase signUpUsecase,
    required SignInUsecase signInUsecase,
    required UserAuthState userCurrentLogin,
  })
    // ignore: prefer_initializing_formals
    : _signUpUsecase = signUpUsecase,
       _signInUsecase = signInUsecase,
       _userCurrentLogin = userCurrentLogin,
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

    on<UserCurrentLogin>((event, emit) async {
      final status = await _userCurrentLogin(NoParams());

      status.fold(
        (l) => emit(AuthFailure(l.message)),
        (r) => emit(AuthSuccess(r)),
      );
    });
  }
}
