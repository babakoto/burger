part of 'dependencies.dart';

class RepositoryDependencies {
  static register() {
    getIt.registerLazySingleton<BurgerRepository>(
      () => BurgerRepositoryImp(
        burgerService: getIt<BurgerService>(),
      ),
    );

    getIt.registerLazySingleton<CartRepository>(
      () => CartRepositoryImp(),
    );
  }
}
