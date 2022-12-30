part of 'dependencies.dart';

class PackageDependencies {
  static register() {
    Dio dio = Dio(BaseOptions(baseUrl: EnvironmentService.host));

    getIt.registerLazySingleton<Dio>(() {
      return dio;
    });

    getIt.registerLazySingleton<InternetConnectionCheckerPlus>(() {
      return InternetConnectionCheckerPlus();
    });
  }
}
