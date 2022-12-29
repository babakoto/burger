import 'package:burger/domain/entities/burger.dart';

abstract class BurgerService {
  Future<List<Burger>> findBurgers();
}
