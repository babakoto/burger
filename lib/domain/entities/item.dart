import 'package:burger/domain/entities/burger.dart';

class Item extends Burger {
  final int quantity;
  final double total;

  const Item({
    required this.quantity,
    required this.total,
    super.isFavorite,
    super.description,
    super.price,
    super.title,
    super.thumbnail,
    super.ref,
  });
}
