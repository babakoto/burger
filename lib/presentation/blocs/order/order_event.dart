part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class OnCreateOrder extends OrderEvent {
  final Burger burger;
  final int quantity;

  const OnCreateOrder({required this.burger, required this.quantity});

  @override
  List<Object> get props => [burger, quantity];
}
