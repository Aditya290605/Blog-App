import 'package:blog_app/core/common/cubits/app_users/app_user_cubit.dart';
import 'package:blog_app/core/network/check_internet_connection.dart';
import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:blog_app/features/auth/data/data_scources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repository/auth_repository_implementation.dart';
import 'package:blog_app/features/auth/domain/repository/auth_respository.dart';
import 'package:blog_app/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/user_auth_state.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/data/datasources/blog_localdata_source.dart';
import 'package:blog_app/features/blog/data/datasources/blog_remote_datasource.dart';
import 'package:blog_app/features/blog/data/repository/blog_repository_implementation.dart';

import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:blog_app/features/blog/domain/usecases/blog_upload.dart';
import 'package:blog_app/features/blog/domain/usecases/fetch_blog.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';

import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: AppSecrets.projectUrl,
    anonKey: AppSecrets.anonKey,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  serviceLocator.registerLazySingleton(() => Hive.box(name: 'blogs'));
  //core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerFactory(() => InternetConnection());

  serviceLocator.registerFactory<CheckInternetConnection>(
    () => CheckInternetConnectionImpl(internetConnection: serviceLocator()),
  );
}

void initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(supabaseClient: serviceLocator()),
  );

  serviceLocator.registerFactory<AuthRespository>(
    () => AuthRepositoryImplementation(
      authRemoteDataSource: serviceLocator(),
      checkInternetConnection: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<SignUpUsecase>(
    () => SignUpUsecase(authRespository: serviceLocator()),
  );

  serviceLocator.registerFactory<SignInUsecase>(
    () => SignInUsecase(authRespository: serviceLocator()),
  );

  serviceLocator.registerFactory<UserAuthState>(
    () => UserAuthState(authRespository: serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      signUpUsecase: serviceLocator(),
      signInUsecase: serviceLocator(),
      userCurrentLogin: serviceLocator(),
      appUserCubit: serviceLocator(),
    ),
  );
}

void uploadBlog() {
  serviceLocator
    ..registerFactory<BlogRemoteDatasource>(
      () => BlogRemoteDatasourceImpl(supabaseClient: serviceLocator()),
    )
    ..registerFactory(() => BlogLocaldataSourceImpl(box: serviceLocator()))
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImplementation(
        blogRemoteDataSource: serviceLocator(),
        checkInternetConnection: serviceLocator(),
        blogLocaldataSource: serviceLocator(),
      ),
    )
    ..registerFactory(() => BlogUpload(blogRepository: serviceLocator()))
    ..registerFactory(() => FetchBlog(blogRepository: serviceLocator()))
    ..registerLazySingleton(
      () => BlogBloc(blogUpload: serviceLocator(), fetchBlog: serviceLocator()),
    );
}
