import 'package:burger/domain/entities/burger.dart';
import 'package:burger/domain/entities/order.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final List<Order> orders;
  final List<Burger> favorites;

  const User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      this.favorites = const [],
      this.orders = const []});

  @override
  List<Object> get props => [
        id,
        firstName,
        lastName,
        email,
        password,
        orders,
      ];

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    List<Order>? orders,
    List<Burger>? favorites,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      orders: orders ?? this.orders,
      favorites: favorites ?? this.favorites,
    );
  }
}
