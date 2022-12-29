import 'package:burger/data/services/burgers/burger_service.dart';
import 'package:burger/data/services/networks/network_service.dart';
import 'package:burger/domain/entities/burger.dart';
import 'package:dio/dio.dart';
import 'package:fos/errors/network_exception.dart';
import 'package:fos/errors/server_exception.dart';
import 'package:fos/errors/unauthorized_exception.dart';

class BurgerServiceImp extends BurgerService {
  final Dio _dio;
  final NetworkService _networkService;

  @override
  Future<List<Burger>> findBurgers() async {
    if (await _networkService.hasConnection) {
      try {
        final response = await _dio.get("/bigburger");
        List data = response.data;
        List<Burger> burgers = data
            .map(
              (burger) => Burger.fromMap(burger),
            )
            .toList();
        return burgers;
      } on DioError catch (e) {
        switch (e.response?.statusCode) {
          case 500:
            throw const ServerException();
          default:
            throw const UnauthorizedException();
        }
      } catch (e) {
        rethrow;
      }
    } else {
      throw const NetworkException();
    }
  }

  BurgerServiceImp({
    required Dio dio,
    required NetworkService networkService,
  })  : _dio = dio,
        _networkService = networkService;
}
