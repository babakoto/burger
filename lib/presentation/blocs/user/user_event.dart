part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class OnAddOrder extends UserEvent {
  final Order order;

  const OnAddOrder({
    required this.order,
  });

  @override
  List<Object> get props => [order];
}

class OnRemoveOrder extends UserEvent {
  final Order order;

  const OnRemoveOrder({
    required this.order,
  });

  @override
  List<Object> get props => [order];
}

class OnUpdateOrder extends UserEvent {
  final Order order;
  final int quantity;

  const OnUpdateOrder({required this.order, required this.quantity});

  @override
  List<Object> get props => [order, quantity];
}

class OnFindOrders extends UserEvent {}
