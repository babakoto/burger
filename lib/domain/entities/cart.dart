import 'package:burger/domain/entities/item.dart';
import 'package:equatable/equatable.dart';

class Cart extends Equatable {
  final String? id;
  final List<Item> items;
  final double total;

  const Cart({
    this.id,
    this.items = const [],
    this.total = 0.0,
  });

  @override
  List<Object?> get props => [id, items, total];
}
