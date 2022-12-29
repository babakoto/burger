import 'package:burger/data/services/burgers/burger_service.dart';
import 'package:burger/domain/entities/burger.dart';
import 'package:burger/domain/repositories/burger_repository.dart';
import 'package:fos/fos.dart';

class BurgerRepositoryImp implements BurgerRepository {
  final BurgerService _burgerService;

  const BurgerRepositoryImp({
    required BurgerService burgerService,
  }) : _burgerService = burgerService;

  @override
  Future<Fos<Failure, List<Burger>>> findBurgers() async {
    try {
      final result = await _burgerService.findBurgers();
      return SuccessResponse(result);
    } on ServerException catch (e) {
      return FailureResponse(
        ServerFailure(message: e.message),
      );
    } on NetworkException catch (e) {
      return FailureResponse(
        NetworkFailure(message: e.message),
      );
    } on UnauthorizedException catch (e) {
      return FailureResponse(
        UnauthorizedFailure(message: e.message),
      );
    }
  }
}
