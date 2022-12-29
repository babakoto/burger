import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:burger/domain/entities/burger.dart';
import 'package:burger/domain/entities/order.dart';
import 'package:burger/domain/repositories/cart_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final CartRepository cartRepository;

  OrderBloc({required this.cartRepository}) : super(const OrderState()) {
    on<OnCreateOrder>(_onCreateOrder);
  }

  FutureOr<void> _onCreateOrder(OnCreateOrder event, Emitter<OrderState> emit) {
    if (event.quantity > 0) {
      double total = event.burger.price! * event.quantity;
      emit(state.copyWith(
        quantity: event.quantity,
        burger: event.burger,
        total: total,
        dateTime: DateTime.now(),
        order: Order(
            dateTime: DateTime.now(),
            burger: event.burger,
            quantity: event.quantity,
            total: total,
            id: const Uuid().v4()),
      ));
    } else {
      emit(state.copyWith(
        quantity: 0,
        burger: null,
        total: 0.0,
      ));
    }
  }
}
