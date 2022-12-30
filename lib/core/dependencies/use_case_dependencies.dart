part of 'dependencies.dart';

class UseCaseDependencies {
  static register() {
    getIt.registerLazySingleton<FindBurgersUseCase>(
      () => FindBurgersUseCase(
        burgerRepository: getIt<BurgerRepository>(),
      ),
    );
  }
}
