import 'package:burger/core/dependencies/dependencies.dart';
import 'package:burger/domain/repositories/burger_repository.dart';
import 'package:burger/domain/usecases/find_burger_use_case.dart';

class UseCaseDependencies {
  static register() {
    getIt.registerLazySingleton<FindBurgersUseCase>(
      () => FindBurgersUseCase(
        burgerRepository: getIt<BurgerRepository>(),
      ),
    );
  }
}
