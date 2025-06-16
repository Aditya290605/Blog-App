import 'package:blog_app/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUsecase _signUpUsecase;
  AuthBloc({required SignUpUsecase signUpUsecase})
    : _signUpUsecase = signUpUsecase,
      super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
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
  }
}
