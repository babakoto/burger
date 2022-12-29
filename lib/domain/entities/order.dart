import 'package:burger/domain/entities/burger.dart';
import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final String? id;
  final DateTime dateTime;
  final Burger burger;
  final int quantity;
  final double total;

  const Order({
    required this.dateTime,
    required this.burger,
    this.id,
    this.quantity = 0,
    this.total = 0.0,
  });

  @override
  List<Object?> get props => [
        dateTime,
        burger,
        quantity,
        total,
        id,
      ];

  Order copyWith({
    String? id,
    DateTime? dateTime,
    Burger? burgers,
    int? quantity,
    double? total,
  }) {
    return Order(
      id: id ?? this.id,
      dateTime: dateTime ?? this.dateTime,
      burger: burgers ?? this.burger,
      quantity: quantity ?? this.quantity,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dateTime': dateTime,
      'burger': burger,
      'quantity': quantity,
      'total': total,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] as String,
      dateTime: map['dateTime'] as DateTime,
      burger: map['burger'] as Burger,
      quantity: map['quantity'] as int,
      total: map['total'] as double,
    );
  }
}
