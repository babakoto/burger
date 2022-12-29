part of 'order_bloc.dart';

class OrderState extends Equatable {
  final DateTime? dateTime;
  final Burger? burger;
  final int quantity;
  final double total;
  final Order? order;

  const OrderState({
    this.dateTime,
    this.burger,
    this.quantity = 0,
    this.total = 0.0,
    this.order,
  });

  OrderState copyWith({
    DateTime? dateTime,
    Burger? burger,
    int? quantity,
    double? total,
    Order? order,
  }) {
    return OrderState(
      dateTime: dateTime ?? this.dateTime,
      burger: burger ?? this.burger,
      quantity: quantity ?? this.quantity,
      total: total ?? this.total,
      order: order ?? this.order,
    );
  }

  @override
  List<Object?> get props => [dateTime, burger, quantity, total, order];
}
