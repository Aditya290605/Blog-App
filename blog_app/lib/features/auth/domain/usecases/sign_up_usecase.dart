import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/use_case_interface.dart';

import 'package:blog_app/core/entities/user_profile.dart';
import 'package:blog_app/features/auth/domain/repository/auth_respository.dart';
import 'package:fpdart/fpdart.dart';

class SignUpUsecase implements UseCase<UserProfile, SignUpParams> {
  final AuthRespository authRespository;
  SignUpUsecase({required this.authRespository});

  @override
  Future<Either<Failures, UserProfile>> call(SignUpParams params) async {
    return await authRespository.signUpWithEmailAndPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class SignUpParams {
  final String name;
  final String email;
  final String password;

  SignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
