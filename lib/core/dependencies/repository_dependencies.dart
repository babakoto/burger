import 'package:burger/core/dependencies/dependencies.dart';
import 'package:burger/data/repositories/burger_repository_imp.dart';
import 'package:burger/data/repositories/cart_repository_imp.dart';
import 'package:burger/data/services/burgers/burger_service.dart';
import 'package:burger/domain/repositories/burger_repository.dart';
import 'package:burger/domain/repositories/cart_repository.dart';

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
