import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:burger/domain/entities/order.dart';
import 'package:burger/domain/entities/user.dart';
import 'package:burger/domain/repositories/cart_repository.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final CartRepository cartRepository;
  UserBloc({required this.cartRepository}) : super(const UserState()) {
    on<OnAddOrder>(_onAddOrder);
    on<OnRemoveOrder>(_onRemoveOrder);
    on<OnUpdateOrder>(_onUpdateOrder);
    on<OnFindOrders>(_onFindOrders);
  }

  FutureOr<void> _onAddOrder(OnAddOrder event, Emitter<UserState> emit) async {
    cartRepository.addOrder(event.order);
    add(OnFindOrders());
  }

  FutureOr<void> _onRemoveOrder(
      OnRemoveOrder event, Emitter<UserState> emit) async {
    cartRepository.removeOrder(event.order);
    add(OnFindOrders());
  }

  FutureOr<void> _onUpdateOrder(OnUpdateOrder event, Emitter<UserState> emit) {
    cartRepository.updateOrder(event.order, event.quantity);

    // refresh orders after update
    add(OnFindOrders());
  }

  FutureOr<void> _onFindOrders(OnFindOrders event, Emitter<UserState> emit) {
    List<Order> orders = cartRepository.findOrders();
    double total = 0.0;
    for (var order in orders) {
      total += order.total;
    }
    emit(state.copyWith(orders: orders, total: total));
  }
}
