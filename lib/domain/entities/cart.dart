import 'package:burger/domain/entities/product.dart';
import 'package:equatable/equatable.dart';

class Cart extends Equatable {
  final String? id;
  final List<Product> products;
  final double total;

  const Cart({
    this.id,
    this.products = const [],
    this.total = 0.0,
  });

  @override
  List<Object?> get props => [id, products, total];
}
