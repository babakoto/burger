import 'package:burger/data/exports.dart';
import 'package:burger/domain/exports.dart';

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
