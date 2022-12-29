import 'package:burger/data/services/networks/network_service.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkServiceImp implements NetworkService {
  final InternetConnectionCheckerPlus _internetConnectionCheckerPlus;

  const NetworkServiceImp({
    required InternetConnectionCheckerPlus internetConnectionCheckerPlus,
  }) : _internetConnectionCheckerPlus = internetConnectionCheckerPlus;

  @override
  Future<bool> get hasConnection =>
      _internetConnectionCheckerPlus.hasConnection;
}
