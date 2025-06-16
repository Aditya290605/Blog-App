import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/data/data_scources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/domain/repository/auth_respository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImplementation implements AuthRespository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImplementation({required this.authRemoteDataSource});

  @override
  Future<Either<Failures, String>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, String>> signUpWithEmailAndPassword({
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
}
