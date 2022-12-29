import 'package:burger/core/errors/environment_exception.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum AppEnv {
  production(fileName: "assets/.env_production"),
  develop(fileName: "assets/.env_develop");

  final String fileName;

  const AppEnv({required this.fileName});
}

class EnvironmentService {
  static Map<String, dynamic> _env = {};
  static final String _host = _env["HOST"];
  static String get host => _host;

  static initEnvironment({required AppEnv appEnv}) async {
    try {
      await dotenv.load(fileName: appEnv.fileName);
      _env = dotenv.env;
    } catch (e, stackTrace) {
      throw EnvironmentException(
        message: 'EnvironmentService (loadENV) error $e - $stackTrace',
      );
    }
  }
}
