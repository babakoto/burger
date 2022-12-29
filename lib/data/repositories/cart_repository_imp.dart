import 'package:burger/domain/entities/order.dart';
import 'package:burger/domain/repositories/cart_repository.dart';

List<Order> _fakeStorage = [];

class CartRepositoryImp implements CartRepository {
  @override
  List<Order> findOrders() {
    return _fakeStorage;
  }

  @override
  void addOrder(Order order) {
    _fakeStorage.add(order);
  }

  @override
  void updateOrder(Order order, int quantity) {
    final newOrder = order.copyWith(
      quantity: quantity,
      total: order.burger.price! * quantity,
    );
    _fakeStorage[_fakeStorage.indexWhere((element) => element.id == order.id)] =
        newOrder;
  }

  @override
  void removeOrder(Order order) {
    _fakeStorage.remove(order);
  }
}
