import 'package:burger/domain/entities/burger.dart';
import 'package:fos/fos.dart';

abstract class BurgerRepository {
  Future<Fos<Failure, List<Burger>>> findBurgers();
}
