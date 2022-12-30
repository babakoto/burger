import 'package:burger/core/environment/environment_service.dart';
import 'package:burger/data/repositories/burger_repository_imp.dart';
import 'package:burger/data/repositories/cart_repository_imp.dart';
import 'package:burger/data/services/burgers/burger_service.dart';
import 'package:burger/data/services/burgers/burger_service_imp.dart';
import 'package:burger/data/services/networks/network_service.dart';
import 'package:burger/data/services/networks/network_service_imp.dart';
import 'package:burger/domain/repositories/burger_repository.dart';
import 'package:burger/domain/repositories/cart_repository.dart';
import 'package:burger/domain/usecases/find_burger_use_case.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

part 'packages_dependencies.dart';
part 'repository_dependencies.dart';
part 'services_dependencies.dart';
part 'use_case_dependencies.dart';

var getIt = GetIt.instance;

Future<void> initializer({required AppEnv appEnv}) async {
  await EnvironmentService.initEnvironment(appEnv: appEnv);
  PackageDependencies.register();
  ServicesDependencies.register();
  RepositoryDependencies.register();
  UseCaseDependencies.register();
}
