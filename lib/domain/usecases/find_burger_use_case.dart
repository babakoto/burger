import 'package:burger/domain/entities/burger.dart';
import 'package:burger/domain/repositories/burger_repository.dart';
import 'package:fos/fos.dart';

class FindBurgersUseCase {
  final BurgerRepository _burgerRepository;

  const FindBurgersUseCase({
    required BurgerRepository burgerRepository,
  }) : _burgerRepository = burgerRepository;

  Future<Fos<Failure, List<Burger>>> call() async {
    return _burgerRepository.findBurgers();
  }
}
