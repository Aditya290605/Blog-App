import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:blog_app/features/auth/data/data_scources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repository/auth_repository_implementation.dart';
import 'package:blog_app/features/auth/domain/repository/auth_respository.dart';
import 'package:blog_app/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: AppSecrets.projectUrl,
    anonKey: AppSecrets.anonKey,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);
}

void initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(supabaseClient: serviceLocator()),
  );

  serviceLocator.registerFactory<AuthRespository>(
    () => AuthRepositoryImplementation(authRemoteDataSource: serviceLocator()),
  );

  serviceLocator.registerFactory<SignUpUsecase>(
    () => SignUpUsecase(authRespository: serviceLocator()),
  );

  serviceLocator.registerFactory<SignInUsecase>(
    () => SignInUsecase(authRespository: serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      signUpUsecase: serviceLocator(),
      signInUsecase: serviceLocator(),
    ),
  );
}
