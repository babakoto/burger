import 'package:burger/core/dependencies/packages_dependencies.dart';
import 'package:burger/core/dependencies/repository_dependencies.dart';
import 'package:burger/core/dependencies/services_dependencies.dart';
import 'package:burger/core/dependencies/use_case_dependencies.dart';
import 'package:burger/core/environment/environment_service.dart';
import 'package:get_it/get_it.dart';

var getIt = GetIt.instance;

Future<void> initializer({required AppEnv appEnv}) async {
  await EnvironmentService.initEnvironment(appEnv: appEnv);
  PackageDependencies.register();
  ServicesDependencies.register();
  RepositoryDependencies.register();
  UseCaseDependencies.register();
}
