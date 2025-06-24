import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/network/check_internet_connection.dart';

import 'package:blog_app/features/auth/data/data_scources/auth_remote_data_source.dart';

import 'package:blog_app/core/entities/user_profile.dart';
import 'package:blog_app/features/auth/domain/repository/auth_respository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImplementation implements AuthRespository {
  final AuthRemoteDataSource authRemoteDataSource;
  final CheckInternetConnection checkInternetConnection;
  AuthRepositoryImplementation({
    required this.authRemoteDataSource,
    required this.checkInternetConnection,
  });

  @override
  Future<Either<Failures, UserProfile>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      if (!await checkInternetConnection.isConnected) {}

      final res = await authRemoteDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(res);
    } on ServerException catch (e) {
      return Left(Failures(e.message));
    } catch (e) {
      throw ServerException('server exception :-  ${e.toString()}');
    }
  }

  @override
  Future<Either<Failures, UserProfile>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final res = await authRemoteDataSource.signUpWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
      );
      return Right(res);
    } on ServerException catch (e) {
      return Left(Failures(e.message));
    } catch (e) {
      throw ServerException('server exception :-  ${e.toString()}');
    }
  }

  @override
  Future<Either<Failures, UserProfile>> getCurrentUserProfile() async {
    try {
      if (!await checkInternetConnection.isConnected) {
        final session = authRemoteDataSource.currentSession;

        if (authRemoteDataSource.currentSession == null) {
          return Left(Failures('No current session found'));
        }

        return Right(
          UserProfile(
            id: session!.user.id,
            name: '',
            email: session.user.email ?? '',
          ),
        );
      }

      if (authRemoteDataSource.currentSession == null) {
        return Left(Failures('No current session found'));
      }
      final res = await authRemoteDataSource.userData();
      return Right(res!);
    } on ServerException catch (e) {
      return Left(Failures(e.message));
    }
  }
}
