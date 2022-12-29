import 'package:burger/domain/entities/order.dart';

abstract class CartRepository {
  List<Order> findOrders();
  void addOrder(Order order);
  void updateOrder(Order order, int quantity);
  void removeOrder(Order order);
}
