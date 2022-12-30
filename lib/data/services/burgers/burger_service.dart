import 'package:burger/domain/exports.dart';

abstract class BurgerService {
  Future<List<Burger>> findBurgers();
}
