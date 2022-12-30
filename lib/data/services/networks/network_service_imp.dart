import 'package:burger/data/exports.dart';

class NetworkServiceImp implements NetworkService {
  final InternetConnectionCheckerPlus _internetConnectionCheckerPlus;

  const NetworkServiceImp({
    required InternetConnectionCheckerPlus internetConnectionCheckerPlus,
  }) : _internetConnectionCheckerPlus = internetConnectionCheckerPlus;

  @override
  Future<bool> get hasConnection =>
      _internetConnectionCheckerPlus.hasConnection;
}
