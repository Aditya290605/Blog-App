part of 'init_dependencies.dart';

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
    ..registerFactory<BlogLocaldataSource>(
      () => BlogLocaldataSourceImpl(box: serviceLocator()),
    )
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
