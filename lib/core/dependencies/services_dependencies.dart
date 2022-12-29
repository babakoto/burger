import 'package:burger/core/dependencies/dependencies.dart';
import 'package:burger/data/services/burgers/burger_service.dart';
import 'package:burger/data/services/burgers/burger_service_imp.dart';
import 'package:burger/data/services/networks/network_service.dart';
import 'package:burger/data/services/networks/network_service_imp.dart';
import 'package:dio/dio.dart';

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
