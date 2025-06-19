import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/use_case_interface.dart';
import 'package:blog_app/core/entities/user_profile.dart';
import 'package:blog_app/features/auth/domain/repository/auth_respository.dart';
import 'package:fpdart/fpdart.dart';

class SignInUsecase implements UseCase<UserProfile, SignInParams> {
  final AuthRespository authRespository;

  SignInUsecase({required this.authRespository});
  @override
  Future<Either<Failures, UserProfile>> call(SignInParams params) async {
    return await authRespository.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class SignInParams {
  final String email;
  final String password;

  SignInParams({required this.email, required this.password});
}
