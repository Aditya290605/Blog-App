import 'package:blog_app/core/error/failures.dart';

import 'package:blog_app/features/auth/domain/entities/user_profile.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRespository {
  Future<Either<Failures, UserProfile>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failures, UserProfile>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
}
