import 'package:burger/core/dependencies/dependencies.dart';
import 'package:burger/core/environment/environment_service.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

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
