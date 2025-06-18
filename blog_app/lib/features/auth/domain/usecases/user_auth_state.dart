import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/use_case_interface.dart';
import 'package:blog_app/features/auth/domain/entities/user_profile.dart';
import 'package:blog_app/features/auth/domain/repository/auth_respository.dart';
import 'package:fpdart/fpdart.dart';

class UserAuthState implements UseCase<UserProfile, NoParams> {
  final AuthRespository authRespository;
  UserAuthState({required this.authRespository});

  @override
  Future<Either<Failures, UserProfile>> call(NoParams params) async {
    return await authRespository.getCurrentUserProfile();
  }
}
