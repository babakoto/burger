part of 'dependencies.dart';

class ServicesDependencies {
  static register() {
    getIt.registerLazySingleton<BurgerService>(
      () => BurgerServiceImp(
        dio: getIt<Dio>(),
        networkService: getIt<NetworkService>(),
      ),
    );

    getIt.registerLazySingleton<NetworkService>(
      () => NetworkServiceImp(
        internetConnectionCheckerPlus: getIt(),
      ),
    );
  }
}
